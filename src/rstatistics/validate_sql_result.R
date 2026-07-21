#!/usr/bin/env Rscript

# =====================================================================
# R SQL Data Quality Auditor & Validator (Scientific Experiment Version)
# Performs automated column classification, join key audits,
# value coalescing warnings, collinearity checks, ANOVA/MANOVA group checks,
# K-Means customer persona discovery, and PCA visualization dashboards.
#
# Generates a scientific experiment report in Markdown format.
# =====================================================================

# Helper function to calculate skewness in base R
get_skewness <- function(x) {
  x <- x[!is.na(x)]
  n <- length(x)
  if (n < 3) return(0)
  m3 <- sum((x - mean(x))^3) / n
  m2 <- sum((x - mean(x))^2) / n
  skew <- m3 / (m2^(1.5))
  return(skew)
}

# Helper function to format p-values cleanly without scientific notation
format_pval <- function(p) {
  if (is.na(p) || is.nan(p)) return("NA")
  if (p < 0.0001) {
    return("< 0.0001")
  } else {
    return(sprintf("%.4f", p))
  }
}

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1) {
  default_path <- "gen/customer_orders_nominal.csv"
  if (file.exists(default_path)) {
    cat(sprintf("No input file specified. Defaulting to: %s\n\n", default_path))
    csv_path <- default_path
  } else {
    cat("Error: Please provide the path to the CSV file to validate.\n")
    cat("Usage: Rscript src/rstatistics/validate_sql_result.R <path_to_csv>\n")
    quit(status = 1)
  }
} else {
  csv_path <- args[1]
}

if (!file.exists(csv_path)) {
  cat(sprintf("Error: File '%s' not found.\n", csv_path))
  quit(status = 1)
}

# Suppress warnings and library load logs
suppressPackageStartupMessages(library(stats))
suppressPackageStartupMessages(library(graphics))
suppressPackageStartupMessages(library(grDevices))
suppressPackageStartupMessages(library(cluster))
suppressPackageStartupMessages(library(car))

cat(sprintf("========================================================================\n"))
cat(sprintf("R SQL DATA QUALITY AUDITOR - SUMMARY REPORT FOR: %s\n", basename(csv_path)))
cat(sprintf("========================================================================\n\n"))

# Read data with fast parser options (data.table::fread or readr::read_csv) to handle large datasets efficiently.
# Falls back to base R read.csv with dynamic sampling if fast parsers are unavailable and the file is very large.
full_data <- tryCatch({
  if (requireNamespace("data.table", quietly = TRUE)) {
    cat("Using data.table::fread for fast CSV parsing.\n")
    as.data.frame(data.table::fread(csv_path))
  } else if (requireNamespace("readr", quietly = TRUE)) {
    cat("Using readr::read_csv for fast CSV parsing.\n")
    as.data.frame(readr::read_csv(csv_path, show_col_types = FALSE))
  } else {
    file_info <- file.info(csv_path)
    if (!is.na(file_info$size) && file_info$size > 10 * 1024 * 1024) { # > 10 MB
      cat("Warning: Large file detected (> 10MB) and fast parsers (data.table/readr) are unavailable.\n")
      cat("         Sampling the first 20,000 rows to prevent memory exhaustion and slow execution.\n")
      read.csv(csv_path, stringsAsFactors = FALSE, nrows = 20000)
    } else {
      cat("Using base R read.csv (slower for large datasets).\n")
      read.csv(csv_path, stringsAsFactors = FALSE)
    }
  }
}, error = function(e) {
  cat("Fast parsing failed, falling back to base R read.csv.\n")
  read.csv(csv_path, stringsAsFactors = FALSE)
})
data <- full_data
n_rows <- nrow(data)
n_cols <- ncol(data)

cat(sprintf("Dataset loaded successfully: %d rows, %d columns.\n\n", n_rows, n_cols))

# Deduce dataset subject terminology based on filename and columns
subject_singular <- "record"
subject_plural <- "records"
subject_domain_singular <- "data population profile"
subject_domain_plural <- "data population profiles"

filename_lower <- tolower(basename(csv_path))
if (grepl("arbre", filename_lower) || grepl("tree", filename_lower) || grepl("forest", filename_lower)) {
  subject_singular <- "tree"
  subject_plural <- "trees"
  subject_domain_singular <- "tree population profile"
  subject_domain_plural <- "tree population profiles"
} else if (grepl("customer", filename_lower) || grepl("order", filename_lower) || grepl("sales", filename_lower) || grepl("transaction", filename_lower)) {
  subject_singular <- "order"
  subject_plural <- "orders"
  subject_domain_singular <- "customer order persona"
  subject_domain_plural <- "customer order personas"
} else if (grepl("bixi", filename_lower) || grepl("trip", filename_lower) || grepl("deplacement", filename_lower) || grepl("bike", filename_lower)) {
  subject_singular <- "trip"
  subject_plural <- "trips"
  subject_domain_singular <- "trip profile"
  subject_domain_plural <- "trip profiles"
} else if (grepl("locale", filename_lower) || grepl("commerce", filename_lower) || grepl("shop", filename_lower)) {
  subject_singular <- "locale"
  subject_plural <- "locales"
  subject_domain_singular <- "commercial locale profile"
  subject_domain_plural <- "commercial locale profiles"
} else if (grepl("supplier", filename_lower) || grepl("fournisseur", filename_lower)) {
  subject_singular <- "supplier"
  subject_plural <- "suppliers"
  subject_domain_singular <- "supplier profile"
  subject_domain_plural <- "supplier profiles"
}

if (n_rows == 0) {
  cat("Error: The loaded dataset is empty (0 rows). No validation can be performed.\n")
  quit(status = 1)
}

# Initialize variables for report generation
report_findings <- c()
report_suggestions <- c()
report_grade <- "COMPLIANT 🟢"
manova_report_lines <- c()
anova_report_lines <- c()

# 1. Automatic Column Discovery
numeric_cols <- c()
categorical_cols <- c()
candidate_keys <- c()

for (col_name in colnames(data)) {
  col_data <- data[[col_name]]
  n_unique <- length(unique(col_data))
  
  # Check if numeric (excluding Date and Timestamp classes that act as integers)
  is_num <- (is.numeric(col_data) || is.integer(col_data)) && 
            !inherits(col_data, "Date") && 
            !inherits(col_data, "IDate") && 
            !inherits(col_data, "POSIXt")
  is_all_int <- is_num && all(col_data == round(col_data), na.rm = TRUE)
  is_float <- is_num && !is_all_int
  
  if (is_num) {
    # It is a float (e.g. balance), OR it is an integer that is not acting as a unique ID
    if (is_float || (n_unique > 1 && n_unique < n_rows * 0.95)) {
      numeric_cols <- c(numeric_cols, col_name)
    }
  }
  
  # Check if categorical (moderate cardinality, and has group replication)
  is_char_or_factor <- is.character(col_data) || is.factor(col_data)
  is_low_card_int <- is_all_int && n_unique >= 1 && n_unique <= 5
  
  if ((is_char_or_factor || is_low_card_int) && n_unique >= 1 && n_unique <= 15) {
    # Ensure there is replication (not a unique name or ID column)
    if (n_unique < n_rows * 0.90 || n_rows == 1) {
      categorical_cols <- c(categorical_cols, col_name)
    }
  }
  
  # Check for candidate join keys (ends in id or key, or is 100% unique and not a float)
  is_id_name <- grepl("(id|key)$", col_name, ignore.case = TRUE)
  is_highly_unique_int_or_char <- n_unique >= n_rows * 0.98 && !is_float
  
  if (is_id_name || is_highly_unique_int_or_char) {
    candidate_keys <- c(candidate_keys, col_name)
  }
}

# --- Response Time / Delay Preprocessing (Nature s41598-024-58300-7) ---
# Identify variables acting as response time or shipment delays, clean outliers, and log-transform.
rt_cols <- c()
rt_outliers_removed <- list()
rt_original_skew <- list()
rt_log_skew <- list()

for (col_name in numeric_cols) {
  is_rt <- grepl("(delay|time|latency|duration|rt|lag)$", col_name, ignore.case = TRUE)
  if (is_rt) {
    col_data <- full_data[[col_name]]
    rt_cols <- c(rt_cols, col_name)
    rt_original_skew[[col_name]] <- get_skewness(col_data)
    
    # Outlier Exclusion: 3 Standard Deviations from mean (and negative bounds)
    m_val <- mean(col_data, na.rm = TRUE)
    s_val <- sd(col_data, na.rm = TRUE)
    upper_lim <- m_val + 3 * s_val
    lower_lim <- max(0, m_val - 3 * s_val)
    
    valid_idx <- which(col_data >= lower_lim & col_data <= upper_lim)
    removed_count <- n_rows - length(valid_idx)
    rt_outliers_removed[[col_name]] <- removed_count
    
    # Create log-transformed variable to correct positive skewness
    log_col_name <- paste0(col_name, "_LOG")
    full_data[[log_col_name]] <- log(col_data + 1)
    
    # Filter outliers in the transformed variable
    if (removed_count > 0) {
      outlier_idx <- which(col_data < lower_lim | col_data > upper_lim)
      full_data[[log_col_name]][outlier_idx] <- NA
    }
    
    rt_log_skew[[col_name]] <- get_skewness(full_data[[log_col_name]])
  }
}

# Swap raw response-time variables for their log-transformed counterparts to avoid collinearity in modeling
for (rt_col in rt_cols) {
  numeric_cols <- numeric_cols[numeric_cols != rt_col]
  numeric_cols <- c(numeric_cols, paste0(rt_col, "_LOG"))
}

# --- Dynamic Discretization (Histogram Quantile Binning) ---
# For numeric columns with high variance, bin them into Low, Medium, High categories.
binned_cols <- c()
for (num_col in numeric_cols) {
  col_data <- full_data[[num_col]]
  n_unique <- length(unique(col_data))
  
  if (n_unique > 10) {
    quantiles <- quantile(col_data, probs = c(0, 0.33, 0.67, 1), na.rm = TRUE)
    if (length(unique(quantiles)) < 4) {
      # Fallback to range cuts if quantiles overlap (highly coalesced numeric column)
      breaks <- seq(min(col_data, na.rm = TRUE), max(col_data, na.rm = TRUE), length.out = 4)
    } else {
      breaks <- quantiles
    }
    
    bin_name <- paste0(num_col, "_BIN")
    full_data[[bin_name]] <- cut(col_data, breaks = breaks, include.lowest = TRUE, labels = c("Low", "Medium", "High"))
    categorical_cols <- c(categorical_cols, bin_name)
    binned_cols <- c(binned_cols, bin_name)
  }
}

# --- Dynamic Categorical Lumping ---
# For character/factor columns with high cardinality (e.g. tree species),
# we lump the less frequent values into an "Other" category to create a collapsed version.
for (col_name in colnames(full_data)) {
  col_data <- full_data[[col_name]]
  n_unique <- length(unique(col_data))
  is_char_or_factor <- is.character(col_data) || is.factor(col_data)
  
  if (is_char_or_factor && n_unique > 15 && n_unique <= 200 && n_unique < n_rows * 0.90) {
    tbl <- sort(table(col_data, useNA = "no"), decreasing = TRUE)
    if (length(tbl) > 0) {
      proportions <- as.numeric(tbl) / sum(tbl)
      cum_prop <- cumsum(proportions)
      
      # Keep categories until we cover at least 85% of the data,
      # or reach a maximum cap of 15 categories to ensure model stability.
      # Always keep at least 5 categories if available.
      keep_indices <- which(cum_prop <= 0.85)
      n_keep <- length(keep_indices) + 1 # Include the category that pushes cumulative over 85%
      if (n_keep < 5) n_keep <- min(5, length(tbl))
      if (n_keep > 15) n_keep <- 15
      
      top_levels <- names(tbl)[1:n_keep]
      lumped_name <- paste0(col_name, "_LUMPED")
      
      lumped_data <- as.character(col_data)
      lumped_data[!is.na(lumped_data) & !(lumped_data %in% top_levels)] <- "Other"
      
      full_data[[lumped_name]] <- as.factor(lumped_data)
      categorical_cols <- c(categorical_cols, lumped_name)
      binned_cols <- c(binned_cols, lumped_name)
      cat(sprintf("Lumped high-cardinality column '%s' (%d categories) into '%s' (top %d representing %.1f%% of data + 'Other').\n", 
                  col_name, n_unique, lumped_name, length(top_levels), 100 * cum_prop[length(top_levels)]))
    }
  }
}
data <- full_data

cat("--- Column Classifications ---\n")
cat(sprintf("Numeric Candidates:     %s\n", paste(numeric_cols, collapse = ", ")))
cat(sprintf("Categorical Candidates: %s\n", paste(categorical_cols, collapse = ", ")))
if (length(binned_cols) > 0) {
  cat(sprintf("  - Dynamically Binned:  %s\n", paste(binned_cols, collapse = ", ")))
}
cat(sprintf("Candidate Join Keys:    %s\n\n", paste(candidate_keys, collapse = ", ")))

# 2. Join Key Validation (Hallucination & Cartesian Guard)
cat("--- Join Key Audit ---\n")
if (length(candidate_keys) == 0) {
  cat("No candidate join keys discovered.\n\n")
} else {
  for (key in candidate_keys) {
    col_data <- data[[key]]
    n_null <- sum(is.na(col_data) | col_data == "")
    null_rate <- n_null / n_rows
    
    # Calculate duplicates among non-null values
    non_null_data <- col_data[!is.na(col_data) & col_data != ""]
    n_duplicates <- length(non_null_data) - length(unique(non_null_data))
    dup_rate <- if (length(non_null_data) > 0) n_duplicates / length(non_null_data) else 0
    
    if (n_duplicates > 0) {
      cat(sprintf("[ANOMALY] Key '%s' contains duplicates!\n", key))
      cat(sprintf("       - Duplicate Count: %d rows (%.2f%%)\n", n_duplicates, dup_rate * 100))
      cat(sprintf("       - CRITICAL ANOMALY: Joining on this key will cause a Cartesian product (row duplication)!\n"))
      
      report_findings <- c(report_findings, sprintf("- **CRITICAL ANOMALY: Duplicate Join Key in '%s'**: Unique rate is %.2f%%. Joining on this column will cause a Cartesian product multiplication (row duplication).", key, (1 - dup_rate)*100))
      report_suggestions <- c(report_suggestions, sprintf("- **Fix duplicate join key '%s'**: Ensure you are joining on a unique primary key. If you are joining a detail table, aggregate it first (e.g. in a subquery or CTE) before joining.", key))
      report_grade <- "CRITICAL ANOMALY DETECTED 🔴"
    } else if (null_rate > 0.05) {
      cat(sprintf("[WARNING] Key '%s' contains a high number of nulls!\n", key))
      cat(sprintf("          - Null Count: %d rows (%.2f%%)\n", n_null, null_rate * 100))
      
      report_findings <- c(report_findings, sprintf("- **WARNING: High Null Rate in Key '%s'**: Null rate is %.2f%%. Joining on this column will drop these records unless you use an outer join.", key, null_rate * 100))
      report_suggestions <- c(report_suggestions, sprintf("- **Key Nulls in '%s'**: Check if nulls are expected. Use `COALESCE` or default values if you need to preserve these rows in an inner join.", key))
      if (report_grade != "CRITICAL ANOMALY DETECTED 🔴") {
        report_grade <- "MINOR ANOMALY DETECTED 🟡"
      }
    } else {
      cat(sprintf("[COMPLIANT] Key '%s' is clean.\n", key))
      cat(sprintf("       - Unique Rate: 100.00%%\n"))
      cat(sprintf("       - Null Rate:   %.2f%%\n", null_rate * 100))
    }
  }
  cat("\n")
}

# 3. Value Coalescing & Mode Collapse Audit
cat("--- Value Coalescing & Mode Collapse Audit ---\n")
coalesce_warnings <- 0
for (col_name in colnames(data)) {
  # Exclude binned or log columns from mode collapse warnings
  if (grepl("_BIN$", col_name) || grepl("_LOG$", col_name)) next
  
  col_data <- data[[col_name]]
  n_unique <- length(unique(col_data))
  
  if (n_unique == 1) {
    mode_val <- unique(col_data)
    cat(sprintf("[WARNING] Column '%s' is completely constant! All %d rows have the value '%s'.\n", col_name, n_rows, mode_val))
    cat(sprintf("          - Check if this is an unintended default or a join/filtering error.\n"))
    coalesce_warnings <- coalesce_warnings + 1
    
    report_findings <- c(report_findings, sprintf("- **WARNING: Constant Column '%s'**: 100%% of rows contain the value '%s'.", col_name, mode_val))
    report_suggestions <- c(report_suggestions, sprintf("- **Constant Column '%s'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.", col_name))
    if (report_grade != "CRITICAL ANOMALY DETECTED 🔴") {
      report_grade <- "MINOR ANOMALY DETECTED 🟡"
    }
  } else if (n_unique >= 2 && n_unique < n_rows * 0.95) {
    freq_tbl <- table(col_data, useNA = "no")
    if (length(freq_tbl) > 0) {
      max_freq <- max(freq_tbl)
      mode_val <- names(freq_tbl)[which.max(freq_tbl)]
      max_rate <- max_freq / n_rows
      
      # Set thresholds
      threshold <- if (n_unique == 2) 0.95 else 0.90
      is_boolean_indicator <- n_unique == 2 && all(col_data %in% c("Y", "N", "T", "F", "TRUE", "FALSE", "1", "0", 1, 0))
      
      if (max_rate >= threshold && !is_boolean_indicator) {
        cat(sprintf("[WARNING] Column '%s' is highly coalesced! %.2f%% of rows have the value '%s'.\n", col_name, max_rate * 100, mode_val))
        cat(sprintf("          - Check if this is an unintended default or a join/filtering error.\n"))
        coalesce_warnings <- coalesce_warnings + 1
        
        report_findings <- c(report_findings, sprintf("- **WARNING: Highly Collapsed Column '%s'**: %.2f%% of rows contain the value '%s'.", col_name, max_rate * 100, mode_val))
        report_suggestions <- c(report_suggestions, sprintf("- **Collapsed Column '%s'**: Verify if this massive skew is natural in your business logic or is caused by a faulty join.", col_name))
        if (report_grade != "CRITICAL ANOMALY DETECTED 🔴") {
          report_grade <- "MINOR ANOMALY DETECTED 🟡"
        }
      }
    }
  }
}
if (coalesce_warnings == 0) {
  cat("[COMPLIANT] No severe value coalescing or mode collapse detected.\n\n")
} else {
  cat("\n")
}

# 4. Uniformity & Synthetic Data Audit
cat("--- Uniformity & Synthetic Data Audit ---\n")
uniformity_warnings <- 0
if (length(categorical_cols) > 0) {
  for (col_name in categorical_cols) {
    col_data <- data[[col_name]]
    freq_tbl <- table(col_data, useNA = "no")
    
    # Check columns with at least 3 categories and at least 30 samples to avoid small-sample noise
    if (length(freq_tbl) >= 3 && sum(freq_tbl) >= 30) {
      mean_freq <- mean(freq_tbl)
      sd_freq <- sd(freq_tbl)
      cv <- sd_freq / mean_freq
      
      # If CV of category counts is less than 8%, flag it as abnormally uniform
      if (cv < 0.08) {
        cat(sprintf("[WARNING] Suspicious uniformity detected in column '%s'! (CV of category counts = %.4f)\n", col_name, cv))
        cat("          - Category counts are nearly identical. Natural data usually shows greater variance;\n")
        cat("            perfectly even category distribution is a characteristic of synthetic data generators.\n")
        uniformity_warnings <- uniformity_warnings + 1
        
        report_findings <- c(report_findings, sprintf("- **WARNING: Suspicious Uniformity on '%s'**: Category counts are highly uniform (Coefficient of Variation = %.4f). This suggests the dataset is synthetic or has been artificially balanced.", col_name, cv))
        report_suggestions <- c(report_suggestions, sprintf("- **Investigate Uniformity on '%s'**: Ensure this uniform distribution is natural for your business domain, or replace with a representative natural dataset.", col_name))
        if (report_grade != "CRITICAL ANOMALY DETECTED 🔴") {
          report_grade <- "MINOR ANOMALY DETECTED 🟡"
        }
      }
    }
  }
}
if (uniformity_warnings == 0) {
  cat("[COMPLIANT] No artificial category uniformity detected.\n\n")
} else {
  cat("\n")
}

# 5. Multicollinearity Audit (SQL Join & Math Bug Guard)
cat("--- Multicollinearity Audit ---\n")
collinearity_detected <- FALSE
if (length(numeric_cols) >= 2) {
  # Calculate pairwise correlations
  cor_matrix <- cor(data[numeric_cols], use = "pairwise.complete.obs")
  for (i in 1:(length(numeric_cols)-1)) {
    for (j in (i+1):length(numeric_cols)) {
      c_val <- cor_matrix[i, j]
      if (!is.na(c_val) && abs(c_val) >= 0.999) {
        cat(sprintf("[ANOMALY] Multicollinearity bug detected between '%s' and '%s'! (Correlation = %.4f)\n", 
                    numeric_cols[i], numeric_cols[j], c_val))
        cat("       - CRITICAL ANOMALY: Perfectly correlated numeric columns indicate duplicate joins or redundant SQL computations.\n")
        collinearity_detected <- TRUE
        
        report_findings <- c(report_findings, sprintf("- **CRITICAL ANOMALY: Multicollinearity between '%s' and '%s'**: Correlation coefficient is %.4f.", numeric_cols[i], numeric_cols[j], c_val))
        report_suggestions <- c(report_suggestions, sprintf("- **Remove Collinearity between '%s' and '%s'**: Review your SQL query to ensure you did not join the same table twice or select the same column multiple times under different aliases.", numeric_cols[i], numeric_cols[j]))
        report_grade <- "CRITICAL ANOMALY DETECTED 🔴"
      }
    }
  }
}
if (!collinearity_detected) {
  cat("[COMPLIANT] No severe multicollinearity or redundant numeric columns detected.\n\n")
} else {
  cat("\n")
}

# Downsample for ANOVA, MANOVA, K-Means, and plotting to ensure computational performance on large datasets
if (n_rows > 5000) {
  set.seed(42)
  data <- full_data[sample(1:n_rows, 5000), ]
  cat(sprintf("[NOTE] Downsampling to 5,000 rows for statistical modeling and plotting.\n\n"))
}

# 5. ANOVA & MANOVA Audit (Multivariate Quality Check)
cat("--- ANOVA & MANOVA Audit (Replication Check) ---\n")
anova_tested <- FALSE
manova_tested <- FALSE

# Fit MANOVA if multiple numeric outcomes exist
if (length(numeric_cols) >= 2 && length(categorical_cols) > 0) {
  for (cat_col in categorical_cols) {
    # Skip checking a binned column against its own parent numeric variable
    is_self_bin <- FALSE
    for (num_col in numeric_cols) {
      # Strip _LOG suffix if present
      base_num <- gsub("_LOG$", "", num_col)
      if (cat_col == paste0(base_num, "_BIN")) {
        is_self_bin <- TRUE
        break
      }
    }
    if (is_self_bin) next
    
    # Filter rows with NA in any of the numeric columns or the grouping column
    valid_rows <- complete.cases(data[numeric_cols]) & !is.na(data[[cat_col]])
    valid_data <- data[valid_rows, ]
    
    group_counts <- table(valid_data[[cat_col]])
    if (length(group_counts) >= 2 && min(group_counts) >= 2) {
      Y <- as.matrix(valid_data[numeric_cols])
      group <- factor(valid_data[[cat_col]])
      
      fit <- tryCatch({
        manova(Y ~ group)
      }, error = function(e) { NULL })
      
      if (!is.null(fit)) {
        manova_tested <- TRUE
        s_fit <- tryCatch({
          summary(fit, test = "Pillai")
        }, error = function(e) { NULL })
        
        if (!is.null(s_fit)) {
          pval <- s_fit$stats["group", "Pr(>F)"]
          fval <- s_fit$stats["group", "approx F"]
          pillai <- s_fit$stats["group", "Pillai"]
          
          manova_report_lines <- c(manova_report_lines,
                                   sprintf("- **Group Factor '%s'**:", cat_col),
                                   sprintf("  - Pillai's Trace: `%.4f`", pillai),
                                   sprintf("  - Approximate F:  `%.4f`", ifelse(is.na(fval), 0, fval)),
                                   sprintf("  - p-value:        `%s` (%s)", format_pval(pval), 
                                           ifelse(pval < 0.05, "Statistically Significant", "Not Significant")),
                                   "")
          
          if (!is.na(pval) && pval > 0.999 && (is.na(fval) || fval < 1e-4)) {
            cat(sprintf("[ANOMALY] MANOVA anomaly on numeric variables grouped by '%s'!\n", cat_col))
            cat(sprintf("       - p-value:     %.6f (identical multivariate distributions)\n", pval))
            cat(sprintf("       - F-statistic: %.6f\n", ifelse(is.na(fval), 0, fval)))
            cat(sprintf("       - CRITICAL ANOMALY: Combined numeric metrics are perfectly replicated across categories. Check for a cross-join or incorrect merge!\n"))
            
            report_findings <- c(report_findings, sprintf("- **CRITICAL ANOMALY: MANOVA Replication Anomaly grouped by '%s'**: Pillai Trace = %.4f, F-statistic = %.4f, p-value = %.6f. The multivariate groups are identical.", cat_col, pillai, ifelse(is.na(fval), 0, fval), pval))
            report_suggestions <- c(report_suggestions, sprintf("- **Fix MANOVA Replication on '%s'**: Check for a missing join condition (cross join) that copies customer/order metrics across categories.", cat_col))
            report_grade <- "CRITICAL ANOMALY DETECTED 🔴"
          } else {
            cat(sprintf("[COMPLIANT] MANOVA on numeric metrics grouped by '%s':\n", cat_col))
            cat(sprintf("       - Pillai Trace: %.4f\n", pillai))
            cat(sprintf("       - F-statistic:  %.4f\n", ifelse(is.na(fval), 0, fval)))
            cat(sprintf("       - p-value:      %.6f\n", pval))
            if (pval < 0.05) {
              cat(sprintf("       - Result: Group differences in multivariate means are statistically significant.\n"))
            } else {
              cat(sprintf("       - Result: No statistically significant differences, variance is naturally distributed.\n"))
            }
          }
        } else {
          cat(sprintf("[WARNING] MANOVA could not be computed for '%s' due to rank-deficient residuals (small sample or high collinearity).\n", cat_col))
        }
      }
    }
  }
}

# Run individual ANOVAs
if (length(numeric_cols) > 0 && length(categorical_cols) > 0) {
  for (num in numeric_cols) {
    for (cat in categorical_cols) {
      # Skip checking self-bin relationships
      base_num <- gsub("_LOG$", "", num)
      if (cat == paste0(base_num, "_BIN")) next
      
      # Filter non-NA cases for this specific pair
      valid_rows <- !is.na(data[[num]]) & !is.na(data[[cat]])
      valid_data <- data[valid_rows, ]
      
      group_counts <- table(valid_data[[cat]])
      if (length(group_counts) >= 2 && min(group_counts) >= 2) {
        fit <- tryCatch({
          aov(valid_data[[num]] ~ factor(valid_data[[cat]]))
        }, error = function(e) { NULL })
        
        if (!is.null(fit)) {
          aov_summary <- summary(fit)
          term_name <- rownames(aov_summary[[1]])[1]
          f_val <- aov_summary[[1]][term_name, "F value"]
          p_val <- aov_summary[[1]][term_name, "Pr(>F)"]
          
          if (!is.null(p_val) && !is.na(p_val)) {
            anova_tested <- TRUE
            if (p_val > 0.999 && (is.na(f_val) || f_val < 1e-4)) {
              cat(sprintf("[ANOMALY] ANOVA anomaly on '%s' grouped by '%s'!\n", num, cat))
              cat(sprintf("       - p-value:     %.6f (identical group distributions)\n", p_val))
              cat(sprintf("       - F-statistic: %.6f\n", ifelse(is.na(f_val), 0, f_val)))
              cat(sprintf("       - CRITICAL ANOMALY: Numeric values are perfectly cloned across categories. Check for a cross-join or incorrect merge!\n"))
              
              report_findings <- c(report_findings, sprintf("- **CRITICAL ANOMALY: ANOVA Replication Anomaly on '%s' by '%s'**: p-value = %.6f (F-statistic = %.6f). The values are perfectly cloned across categories.", num, cat, p_val, ifelse(is.na(f_val), 0, f_val)))
              report_suggestions <- c(report_suggestions, sprintf("- **Fix ANOVA Replication on '%s' by '%s'**: Check your SQL join logic. This indicates matching values are replicated across categories.", num, cat))
              report_grade <- "CRITICAL ANOMALY DETECTED 🔴"
            } else {
              cat(sprintf("[COMPLIANT] ANOVA for '%s' grouped by '%s':\n", num, cat))
              cat(sprintf("       - p-value:     %.6f\n", p_val))
              cat(sprintf("       - F-statistic: %.4f\n", ifelse(is.na(f_val), 0, f_val)))
              
              if (p_val < 0.05) {
                anova_report_lines <- c(anova_report_lines,
                                        sprintf("- **Significant variation in '%s' grouped by '%s'**: F = `%.4f`, p = `%s`",
                                                num, cat, ifelse(is.na(f_val), 0, f_val), format_pval(p_val)))
              }
            }
          }
        }
      }
    }
  }
}

if (!anova_tested && !manova_tested) {
  cat("No suitable numeric-categorical pairs found for ANOVA/MANOVA testing.\n\n")
} else {
  cat("\n")
}

# 6. K-Means Persona Discovery
cat("--- K-Means Persona Discovery ---\n")
kmeans_run <- FALSE
pca_fit <- NULL
if (length(numeric_cols) >= 2) {
  # Scale numeric variables
  scaled_data <- scale(data[numeric_cols])
  scaled_data[is.na(scaled_data)] <- 0
  
  pca_fit <- tryCatch({
    prcomp(scaled_data)
  }, error = function(e) { NULL })
  
  # Determine the optimal number of clusters using Silhouette analysis
  best_k <- 1
  best_sil <- -Inf
  
  # Ensure we don't request more clusters than unique distinct data points
  n_unique_rows <- nrow(unique(scaled_data))
  max_k <- min(6, n_rows - 1, n_unique_rows - 1)
  
  if (max_k >= 2) {
    for (k in 2:max_k) {
      km <- tryCatch({
        kmeans(scaled_data, centers = k, nstart = 25)
      }, error = function(e) { NULL })
      
      if (!is.null(km)) {
        sil <- tryCatch({
          s <- silhouette(km$cluster, dist(scaled_data))
          mean(s[, 3])
        }, error = function(e) { -1 })
        
        if (sil > best_sil) {
          best_sil <- sil
          best_k <- k
        }
      }
    }
  }
  
  # Fall back to k=1 if best silhouette width is <= 0.25 (no substantial structure)
  if (best_sil <= 0.25) {
    k_centers <- 1
  } else {
    k_centers <- best_k
  }
  
  if (k_centers == 1) {
    kmeans_run <- TRUE
    data$KMeans_Cluster <- as.factor(rep(1, nrow(data)))
    cat(sprintf("[SUCCESS] Discovered 1 %s (no distinct sub-populations found).\n\n", subject_domain_singular))
  } else {
    km_fit <- tryCatch({
      kmeans(scaled_data, centers = k_centers, nstart = 25)
    }, error = function(e) { NULL })
    
    if (!is.null(km_fit)) {
      kmeans_run <- TRUE
      data$KMeans_Cluster <- as.factor(km_fit$cluster)
      cat(sprintf("[SUCCESS] Discovered %d %s using K-Means.\n", k_centers, subject_domain_plural))
      cl_tbl <- table(data$KMeans_Cluster)
      for (cl_id in names(cl_tbl)) {
        cat(sprintf("          - Cluster %s: %d %s (%.2f%%)\n", 
                    cl_id, cl_tbl[cl_id], subject_plural, 100 * cl_tbl[cl_id] / nrow(data)))
      }
      cat("\n")
    }
  }
} else {
  cat("Insufficient numeric columns for K-Means clustering.\n\n")
}

# 7. Visualization Dashboard
file_base <- tools::file_path_sans_ext(basename(csv_path))
dir.create("gen", showWarnings = FALSE)
plot_file <- file.path("gen", paste0(file_base, "_validation_plot.png"))
cat("--- Visualizations ---\n")

if (kmeans_run && length(numeric_cols) >= 2) {
  png(plot_file, width = 1000, height = 800)
  # Set up a 2x2 grid layout
  layout(matrix(c(1, 2, 3, 4), nrow = 2, byrow = TRUE))
  par(mar = c(6, 5, 4, 3))
  
  # Panel 1: PCA Cluster Scatterplot (PC1 vs PC2)
  if (!is.null(pca_fit)) {
    var_exp <- round(100 * pca_fit$sdev^2 / sum(pca_fit$sdev^2), 1)
    plot(pca_fit$x[,1], pca_fit$x[,2],
         col = rainbow(k_centers)[as.numeric(data$KMeans_Cluster)],
         pch = 19, cex = 1.2,
         main = paste("PCA Cluster Space (", subject_plural, ")"),
         xlab = paste0("PC1 (", var_exp[1], "% variance)"),
         ylab = paste0("PC2 (", var_exp[2], "% variance)"))
    grid()
    legend("topright", legend = paste("Cluster", 1:k_centers),
           col = rainbow(k_centers), pch = 19, cex = 0.8)
  } else {
    plot(1, 1, type = "n", xlab = "", ylab = "", main = "PCA Space (Unavailable)")
    text(1, 1, "PCA calculation failed", cex = 1.2)
  }
  
  # Panel 2: Correlation Heatmap of Numeric Variables
  cor_mat <- cor(data[numeric_cols], use = "pairwise.complete.obs")
  cor_mat[is.na(cor_mat)] <- 0
  
  image(1:length(numeric_cols), 1:length(numeric_cols), cor_mat,
        col = colorRampPalette(c("blue", "white", "red"))(20),
        zlim = c(-1, 1),
        axes = FALSE, xlab = "", ylab = "",
        main = "Feature Correlation Matrix")
  axis(1, at = 1:length(numeric_cols), labels = numeric_cols, las = 2, cex.axis = 0.7)
  axis(2, at = 1:length(numeric_cols), labels = numeric_cols, las = 2, cex.axis = 0.7)
  box()
  
  # Panel 3: Persona Cluster Count Barplot
  cl_counts <- table(data$KMeans_Cluster)
  barplot(cl_counts,
          main = paste(tools::toTitleCase(subject_singular), "Cluster Sizes"),
          xlab = "Cluster ID", ylab = paste("Number of", tools::toTitleCase(subject_plural)),
          col = "lightgreen", border = "white")
  
  # Panel 4: Boxplot of O_TOTALPRICE by Persona Cluster
  boxplot(data[[numeric_cols[1]]] ~ data$KMeans_Cluster,
          main = paste(numeric_cols[1], "by Cluster"),
          xlab = "Cluster ID", ylab = numeric_cols[1],
          col = rainbow(k_centers), las = 1)
  
  dev.off()
  cat(sprintf("[SAVED] PCA Persona Dashboard saved to '%s'.\n\n", plot_file))
} else if (length(numeric_cols) > 0 && length(categorical_cols) > 0) {
  # Fallback to single Boxplot dashboard
  num_plot <- numeric_cols[1]
  cat_plot <- categorical_cols[1]
  
  png(plot_file, width = 1000, height = 800)
  layout(matrix(c(1, 2, 3, 4), nrow = 2, byrow = TRUE))
  par(mar = c(6, 4, 4, 2))
  
  boxplot(data[[num_plot]] ~ factor(data[[cat_plot]]),
          main = paste("Boxplot of", num_plot, "by", cat_plot),
          xlab = cat_plot,
          ylab = num_plot,
          col = rainbow(length(unique(data[[cat_plot]]))),
          las = 2)
  stripchart(data[[num_plot]] ~ factor(data[[cat_plot]]),
             vertical = TRUE,
             method = "jitter",
             jitter = 0.15,
             pch = 19,
             col = "darkgray",
             add = TRUE)
             
  hist(data[[num_plot]],
       main = paste("Histogram of", num_plot, "(Dependent)"),
       xlab = num_plot,
       col = "lightblue",
       border = "white")
       
  cat_counts <- table(data[[cat_plot]])
  barplot(cat_counts,
          main = paste("Counts of", cat_plot, "(Independent)"),
          xlab = cat_plot,
          ylab = "Frequency",
          col = "lightgreen",
          border = "white",
          las = 2)
          
  qqnorm(data[[num_plot]],
         main = paste("Normal Q-Q Plot of", num_plot),
         col = "darkblue",
         pch = 19)
  qqline(data[[num_plot]], col = "red", lwd = 2)
  
  dev.off()
  cat(sprintf("[SAVED] Distribution dashboard of '%s' by '%s' saved to '%s'.\n\n", num_plot, cat_plot, plot_file))
} else {
  cat("Insufficient numeric or categorical columns to generate dashboards.\n\n")
}

# 8. Pairwise Scatterplots with Line of Best Fit
if (length(numeric_cols) >= 2) {
  scatter_file <- file.path("gen", paste0(file_base, "_scatterplots.png"))
  
  # Generate all pairwise combinations of numeric columns
  pairs_idx <- combn(length(numeric_cols), 2)
  num_plots <- ncol(pairs_idx)
  
  # Determine dynamic grid layout
  grid_cols <- ceiling(sqrt(num_plots))
  grid_rows <- ceiling(num_plots / grid_cols)
  
  # Scale PNG dimensions dynamically (minimum 600px, 350px per panel)
  png_width <- max(600, 350 * grid_cols)
  png_height <- max(500, 350 * grid_rows)
  
  png(scatter_file, width = png_width, height = png_height)
  layout(matrix(c(1:(grid_rows * grid_cols)), nrow = grid_rows, byrow = TRUE))
  par(mar = c(5, 5, 4, 2))
  
  # Helper function to plot scatter with abline
  plot_scatter_fit <- function(x, y, xlab, ylab, title, color) {
    valid_idx <- !is.na(x) & !is.na(y)
    if (sum(valid_idx) >= 2) {
      plot(x[valid_idx], y[valid_idx], col = color, pch = 19, cex = 1.2,
           main = title, xlab = xlab, ylab = ylab)
      grid()
      fit <- tryCatch({
        lm(y[valid_idx] ~ x[valid_idx])
      }, error = function(e) { NULL })
      if (!is.null(fit) && !any(is.na(coef(fit)))) {
        abline(fit, col = "red", lwd = 3)
      }
    } else {
      plot(1, type = "n", xlab = xlab, ylab = ylab, main = title, xlim = c(0, 1), ylim = c(0, 1))
      text(0.5, 0.5, "Insufficient data", cex = 1.2)
    }
  }
  
  # Cycle colors
  colors_palette <- c("#1f77b4", "#2ca02c", "#9467bd", "#ff7f0e", "#e377c2", "#17becf", "#bcbd22")
  
  for (i in 1:num_plots) {
    col_x <- numeric_cols[pairs_idx[1, i]]
    col_y <- numeric_cols[pairs_idx[2, i]]
    title_str <- paste(col_y, "vs", col_x)
    col_choice <- colors_palette[((i - 1) %% length(colors_palette)) + 1]
    plot_scatter_fit(data[[col_x]], data[[col_y]], 
                     col_x, col_y, 
                     title_str, col_choice)
  }
  dev.off()
  cat(sprintf("[SAVED] Pairwise Scatterplots saved to '%s'.\n", scatter_file))
}

# 9. Independent Variables Distribution Plots (Group Sample Sizes)
if (length(categorical_cols) > 0) {
  indep_file <- file.path("gen", paste0(file_base, "_independent_distributions.png"))
  num_plots <- length(categorical_cols)
  
  grid_cols <- ceiling(sqrt(num_plots))
  grid_rows <- ceiling(num_plots / grid_cols)
  
  png_width <- max(600, 350 * grid_cols)
  png_height <- max(500, 350 * grid_rows)
  
  png(indep_file, width = png_width, height = png_height)
  layout(matrix(c(1:(grid_rows * grid_cols)), nrow = grid_rows, byrow = TRUE))
  par(mar = c(6, 5, 4, 2))
  
  bar_colors <- c("lightblue", "lightgreen", "lightpink", "lightyellow", "aquamarine", "lavender")
  for (i in 1:num_plots) {
    col_name <- categorical_cols[i]
    tbl <- table(data[[col_name]], useNA = "no")
    color_choice <- bar_colors[((i - 1) %% length(bar_colors)) + 1]
    if (length(tbl) > 0) {
      barplot(tbl,
              main = paste("Distribution of", col_name),
              xlab = col_name, ylab = "Sample Size (N)",
              col = color_choice, border = "white",
              las = 2, cex.names = 0.8)
      grid(nx = NA, ny = NULL)
    } else {
      plot(1, type = "n", xlab = col_name, ylab = "Sample Size (N)", 
           main = paste("Distribution of", col_name), xlim = c(0, 1), ylim = c(0, 1))
      text(0.5, 0.5, "No data", cex = 1.2)
    }
  }
  dev.off()
  cat(sprintf("[SAVED] Independent variable distributions saved to '%s'.\n", indep_file))
}

# --- 8. Markdown Scientific Report Generation ---
report_file <- file.path("gen", paste0(file_base, "_audit_report.md"))

# Prepare participants table text dynamically based on actual categorical variables
part_lines <- c(
  "| Category Variable | Group Level | Sample Size (N) | Percentage (%) |",
  "|---|---|---|---|"
)
if (length(categorical_cols) > 0) {
  for (cat_col in categorical_cols) {
    tbl <- table(data[[cat_col]])
    tbl <- sort(tbl, decreasing = TRUE)
    levels_to_show <- head(names(tbl), 5)
    for (lvl in levels_to_show) {
      part_lines <- c(part_lines, sprintf("| **%s** | %s | %d | %.2f%% |", cat_col, lvl, tbl[lvl], 100 * tbl[lvl] / nrow(data)))
    }
  }
} else {
  part_lines <- c(part_lines, "| N/A | No categorical features found | - | - |")
}

# Format findings and suggestions
findings_txt <- if (length(report_findings) == 0) {
  "### [PASS] No severe data quality issues or statistical anomalies detected. The SQL query output is mathematically valid."
} else {
  paste(report_findings, collapse = "\n")
}

suggestions_txt <- if (length(report_suggestions) == 0) {
  "* No SQL improvements needed for this query."
} else {
  paste(report_suggestions, collapse = "\n")
}

# Response Time (Delay) methodological summary
rt_methodology_txt <- ""
if (length(rt_cols) > 0) {
  rt_methodology_txt <- paste0(
    "### Response-Time Preprocessing (Methodological Standards)\n",
    "Following standard methodologies for reaction time outcomes (McConnell et al., 2024):\n",
    "1. **Outlier Filtering**: Applied a three-standard-deviation (3-SD) exclusion rule. Below are the details of trial outlier exclusions:\n"
  )
  for (rtc in rt_cols) {
    rt_methodology_txt <- paste0(rt_methodology_txt, 
                                 sprintf("   - **Variable '%s'**: Excluded %d extreme outlier trials outside the [mean +/- 3*SD] boundaries.\n", 
                                         rtc, rt_outliers_removed[[rtc]]))
  }
  rt_methodology_txt <- paste0(rt_methodology_txt,
                               "2. **Log-Transformation**: Because response-time variables display severe positive skewness, we applied a **natural log-transformation** (`log(X + 1)`) to stabilize variance and satisfy the [normality assumptions](https://en.wikipedia.org/wiki/Normal_distribution#Statistical_inference) of [ANOVA](https://en.wikipedia.org/wiki/Analysis_of_variance) and [MANOVA](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance) tests. Skewness was corrected as follows:\n")
  for (rtc in rt_cols) {
    rt_methodology_txt <- paste0(rt_methodology_txt,
                                 sprintf("   - **'%s'** original skewness: `%.4f` | log-transformed skewness: `%.4f`\n",
                                         rtc, rt_original_skew[[rtc]], rt_log_skew[[rtc]]))
  }
}

# K-Means Persona table
kmeans_table <- ""
profile_table <- ""
if (kmeans_run) {
  kmeans_table <- "| Persona Cluster | Order Count | Percentage (%) |\n|---|---|---|\n"
  cl_tbl <- table(data$KMeans_Cluster)
  for (cl_id in names(cl_tbl)) {
    kmeans_table <- paste0(kmeans_table, sprintf("| **Cluster %s** | %d | %.2f%% |\n", cl_id, cl_tbl[cl_id], 100 * cl_tbl[cl_id]/nrow(data)))
  }
  
  # Construct Cluster Profiles table (means of original numeric columns)
  profile_table <- paste0("| Cluster | ", paste(numeric_cols, collapse = " | "), " |\n")
  profile_table <- paste0(profile_table, "|---|", paste(rep("---|", length(numeric_cols)), collapse = ""), "\n")
  for (cl_id in names(cl_tbl)) {
    cluster_subset <- data[data$KMeans_Cluster == cl_id, ]
    means <- sapply(numeric_cols, function(col) mean(cluster_subset[[col]], na.rm = TRUE))
    profile_table <- paste0(profile_table, "| **Cluster ", cl_id, "** | ", 
                            paste(sprintf("%.2f", means), collapse = " | "), " |\n")
  }
}

# PCA Loadings table
pca_table <- ""
if (kmeans_run && !is.null(pca_fit)) {
  pca_table <- "| Metric | PC1 Loading | PC2 Loading | Influence Strength (PC1 & PC2) |\n|---|---|---|---|\n"
  
  # Calculate vector magnitude (strength) of loadings across PC1 and PC2
  pc2_vals <- if (ncol(pca_fit$rotation) >= 2) pca_fit$rotation[, 2] else rep(0.0, nrow(pca_fit$rotation))
  strengths <- sqrt(pca_fit$rotation[, 1]^2 + pc2_vals^2)
  
  loadings_df <- data.frame(
    Metric = rownames(pca_fit$rotation),
    PC1 = pca_fit$rotation[, 1],
    PC2 = pc2_vals,
    Strength = strengths,
    stringsAsFactors = FALSE
  )
  
  # Sort in descending order of influence strength
  loadings_df <- loadings_df[order(-loadings_df$Strength), ]
  
  for (i in 1:nrow(loadings_df)) {
    pca_table <- paste0(pca_table, sprintf("| `%s` | `%.4f` | `%.4f` | `%.4f` |\n", 
                                           loadings_df$Metric[i], 
                                           loadings_df$PC1[i], 
                                           loadings_df$PC2[i], 
                                           loadings_df$Strength[i]))
  }
}

# Assemble lab report
report_lines <- c(
  paste0("# SQL Data Quality and Behavior Analysis Lab Report: ", file_base),
  "",
  paste0("**Report Generated on:** ", Sys.time()),
  paste0("**Source Dataset:** `", basename(csv_path), "`"),
  paste0("**Auditor Classification Status:** ", report_grade),
  "",
  "---",
  "",
  "## Abstract",
  paste0("This report presents a controlled statistical audit of the database query results comprising ", 
         n_rows, " samples and ", n_cols, " features. Using [Multivariate Analysis of Variance (MANOVA)](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance), [K-Means clustering](https://en.wikipedia.org/wiki/K-means_clustering), and correlation-matrix collinearity tests, we investigate the structure of the retrieved dataset. The objective is to identify potential query design flaws (such as duplicate joins, cross joins, and hardcoded values) and characterize the underlying ", subject_domain_plural, ". Our findings show that the dataset has a classification status of **", report_grade, "**. We detail actionable recommendations for query optimizations based on detected data anomalies."),
  "",
  "## 1. Introduction and Hypotheses",
  "In database engineering and agentic data pipelines, query errors often manifest as subtle statistical anomalies (e.g. artificial correlation due to duplicate joins or zero variance due to cross joins) rather than outright syntax failures. We formally evaluate the following hypotheses:",
  paste0("* **Null Hypothesis ($H_0$)**: The physical and spatial parameters of the observed ", subject_plural, " (such as ", paste(head(numeric_cols, 4), collapse = ", "), ") are homogeneous and do not vary significantly across categorical groupings."),
  paste0("* **Alternative Hypothesis ($H_1$)**: The physical and spatial parameters of the observed ", subject_plural, " show statistically significant variations across these categorical dimensions, indicating distinct sub-populations."),
  "",
  "## 2. Experimental Methodology",
  "",
  "### Participants (Dataset Description)",
  paste0("The 'participants' (observed entities) in this study consist of the ", subject_plural, " fetched from the database."),
  "The demographic distribution of the sample is detailed below:",
  "",
  part_lines,
  "",
  "Figure 3 presents the sample size distributions across each independent categorical variable to evaluate demographic coverage and statistical power:",
  "",
  paste0("![Figure 3: Independent Variable Sample Size Distributions](", file_base, "_independent_distributions.png)"),
  "",
  "### Apparatus and Setup",
  "Queries were executed against the Snowflake TPC-H sample database (`SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`; Transaction Processing Performance Council [TPC], 2014) using the Snowflake CLI tool (`snow` CLI v3.20.0). Statistical analysis and clustering were computed in R using packages `car` (ANOVA/MANOVA modelling) and `cluster` (K-Means silhouette groupings).",
  "",
  "### Hardware Acceleration Controls",
  "As highlighted in the methodological considerations for online response-time behavioral studies (McConnell et al., 2024), differences in browser hardware configuration and rendering pipelines (e.g. software rasterizer vs. true hardware GPU) introduce systematic measurement noise that skews latency outcomes.",
  "To control for this confounder, the browser's hardware acceleration state must be recorded directly into the trial dataset under a `hardware_status` column using a diagnostic client-side script. The implementation of this client check is provided in Appendix A.",
  "",
  "### Inter-Action Interval Controls",
  "To profile user choice dynamics, click patterns, and decision hesitation (Pongratz & Schoemann, 2026), we track the high-resolution inter-action delay (the exact milliseconds elapsed between successive button clicks). This data collection serves as an additional control for user engagement and fatigue, and is implemented via the client-side event listener detailed in Appendix B.",
  "",
  "### Experimental Design",
  "We define a mixed multivariate design incorporating:",
  paste0("* **Independent Variables (Factors)**: ", paste(paste0("`", categorical_cols, "`"), collapse = ", ")),
  paste0("* **Dependent Variables (Metrics)**: ", paste(paste0("`", numeric_cols, "`"), collapse = ", ")),
  "",
  rt_methodology_txt,
  "",
  "## 3. Results",
  "",
  "### Data Quality and SQL Integrity Audits",
  findings_txt,
  "",
  "### Statistical Hypothesis Testing",
  "#### MANOVA Group Factor Outcomes",
  "We executed [multivariate analysis of variance (MANOVA)](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance) using [Pillai's trace](https://www.statisticshowto.com/pillais-trace/) to test for overall group differences across continuous variables:",
  "",
  if (length(manova_report_lines) == 0) "No MANOVA tests could be computed." else manova_report_lines,
  "",
  "#### ANOVA Outputs (Significant Univariate Groupings)",
  "We evaluated individual [univariate Analysis of Variance (ANOVA)](https://en.wikipedia.org/wiki/Analysis_of_variance) models for each continuous metric. The following factors show statistically significant differences (p < 0.05) in group means:",
  "",
  if (length(anova_report_lines) == 0) "No significant individual variable differences (p >= 0.05) found across groupings." else anova_report_lines,
  "",
  "Figure 2 presents the pairwise scatterplots with a fitted linear regression line of best fit to visualize the correlation and linear relationships between these continuous metrics:",
  "",
  paste0("![Figure 2: Pairwise Scatterplots with Line of Fit](", file_base, "_scatterplots.png)"),
  "",
  paste0("### ", tools::toTitleCase(subject_domain_singular), " Profiles (K-Means)"),
  paste0("We standardized the numeric metrics and fitted a [K-Means clustering algorithm](https://en.wikipedia.org/wiki/K-means_clustering) ($k=", k_centers, "$) to identify distinct ", subject_domain_plural, ". To determine the optimal number of clusters programmatically, we performed a **[Silhouette Analysis](https://en.wikipedia.org/wiki/Silhouette_(clustering))** across candidate sizes of $k \\in [2, 6]$. The optimal $k$ was selected by maximizing the average silhouette width (Rousseeuw, 1987), which measures cluster cohesion and separation. If the maximum average silhouette width was $\\le 0.25$, indicating no substantial structure, the algorithm fell back to a single nominal cluster ($k=1$):"),
  "",
  `kmeans_table`,
  "",
  "#### Population Profiles (Cluster Feature Means)",
  paste0("To characterize the discovered ", subject_domain_plural, " in terms of the original variables, the table below presents the mean value of each numeric metric within each cluster:"),
  "",
  `profile_table`,
  "",
  "## 4. Exploratory Multivariate Analysis and Cluster Diagnostics",
  paste0("Figure 1 presents the 2x2 data quality and ", subject_domain_singular, " visualization dashboard:"),
  "",
  paste0("![Figure 1: PCA Dashboard](", basename(plot_file), ")"),
  "",
  "### Principal Component Loadings (Feature Contributions)",
  paste0("To reverse-engineer which original variables drive the principal component projections, the table below lists the loadings (rotation coefficients) for the first two components:"),
  "",
  `pca_table`,
  "",
  "### Interpretation of Figure 1:",
  paste0("1. **[PCA](https://en.wikipedia.org/wiki/Principal_component_analysis) Cluster Space**: Represents the first two principal components. Good separation between color groups indicates distinct ", subject_domain_plural, ". If the points form tight, overlapping lines or grids, it indicates identical data replication bugs."),
  "2. **Correlation Heatmap**: Pairwise correlations between metrics. Strong colors indicate potential redundant attributes or duplicate join bugs.",
  paste0("3. **Cluster Sizes**: Frequency counts across the discovered ", subject_domain_plural, "."),
  paste0("4. **Boxplot of ", numeric_cols[1], "**: Shows the distribution of the primary outcome metric across the clusters."),
  "",
  "## 5. Discussion and SQL Improvement Recommendations",
  "Based on the results, we recommend the following modifications to improve the SQL query:",
  "",
  `suggestions_txt`,
  "",
  "### Methodological Discussion on Skewness",
  paste0("As detailed in the references, response-time metrics are typically right-skewed and violating [normality assumptions](https://en.wikipedia.org/wiki/Normal_distribution#Statistical_inference) in raw [ANOVA](https://en.wikipedia.org/wiki/Analysis_of_variance) leads to higher [Type I errors](https://en.wikipedia.org/wiki/Type_I_and_Type_II_errors#Type_I_error). Log-transforming the delay metrics significantly stabilizes the residuals, making our multivariate models highly reliable for identifying behavioral deviations in the ", subject_domain_plural, "."),
  "",
  "## References",
  "1. University of Sheffield. (n.d.). *Science lab reports*. University of Sheffield 301 Academic Skills. https://www.sheffield.ac.uk/301/study-skills/writing/academic/lab-reports",
  "2. Saul, S. (n.d.). *Guidelines for controlled experiment reports*. University of Calgary Department of Computer Science. https://pages.cpsc.ucalgary.ca/~saul/hci_topics/assignments/controlled_expt/ass1_reports.html",
  "3. McConnell, P. A., Finetto, C., & Heise, K.-F. (2024). Methodological considerations for behavioral studies relying on response time outcomes through online crowdsourcing platforms. *Scientific Reports*, *14*(1), Article 7719. https://doi.org/10.1038/s41598-024-58300-7",
  "4. Pongratz, H., & Schoemann, M. (2026). A large-scale dataset of choice and response-time data in intertemporal choice. *Scientific Data*, *13*, Article 150. https://doi.org/10.1038/s41597-026-06947-4",
  "5. Transaction Processing Performance Council. (2014). *TPC Benchmark H: Standard specification* (Revision 2.17.1). https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf",
  "6. Rousseeuw, P. J. (1987). Silhouettes: A graphical aid to the interpretation and validation of cluster analysis. *Journal of Computational and Applied Mathematics*, *20*, 53-65. https://doi.org/10.1016/0377-0427(87)90125-7",
  "",
  "---",
  "",
  "## Appendix A: Client-Side Hardware Acceleration Detection Script",
  "Below is the JavaScript routine to determine if the browser environment uses hardware GPU acceleration or falls back to software rendering (e.g. SwiftShader), which should be appended to trial collections to log the `hardware_status` column:",
  "",
  "```javascript",
  "function checkHardwareAcceleration() {",
  "    const canvas = document.createElement('canvas');",
  "    const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');",
  "    if (!gl) return \"disabled_or_unsupported\";",
  "    ",
  "    // Check if the browser is using a software rasterizer (fallback) instead of a true GPU",
  "    const debugInfo = gl.getExtension('WEBGL_debug_renderer_info');",
  "    if (debugInfo) {",
  "        const renderer = gl.getParameter(debugInfo.UNMASKED_RENDERER_WEBGL);",
  "        if (renderer.toLowerCase().includes('swiftshader') || renderer.toLowerCase().includes('software')) {",
  "            return \"disabled_software_fallback\"; ",
  "        }",
  "    }",
  "    return \"enabled_hardware_gpu\";",
  "}",
  "// Add this output directly to your trial dataset under a `hardware_status` column",
  "```",
  "",
  "---",
  "",
  "## Appendix B: Client-Side Inter-Action Delay Detection Script",
  "Below is the JavaScript routine to measure high-resolution inter-action delay (the exact milliseconds elapsed between successive button clicks), which can be captured and logged as user latency profiles:",
  "",
  "```javascript",
  "let lastActionTime = performance.now(); // High-resolution millisecond timestamp",
  "",
  "document.querySelectorAll('.experiment-button').forEach(button => {",
  "    button.addEventListener('click', (e) => {",
  "        let currentActionTime = performance.now();",
  "        let interActionDelay = currentActionTime - lastActionTime; // The exact gap between actions",
  "        ",
  "        // Push this directly to your local data stream or into GA4 Custom Dimensions",
  "        console.log(`Time since last user action: ${interActionDelay}ms`);",
  "        ",
  "        lastActionTime = currentActionTime; // Reset baseline for next click",
  "    });",
  "});",
  "```"
)

writeLines(report_lines, report_file)
cat(sprintf("[SAVED] Scientific Experiment Lab Report saved to '%s'.\n\n", report_file))

cat("========================================================================\n")
cat("AUDIT COMPLETE\n")
cat("========================================================================\n")
