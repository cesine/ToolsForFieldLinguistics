#!/usr/bin/env Rscript

# =====================================================================
# R SQL Data Quality Auditor & Validator
# Performs automated column classification, join key audits,
# value coalescing warnings, ANOVA group checks, and plot generation.
#
# Usage: Rscript src/rstatistics/validate_sql_result.R <path_to_csv>
# =====================================================================

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1) {
  default_path <- "gen/tpch_customer_good.csv"
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

cat(sprintf("========================================================================\n"))
cat(sprintf("R SQL DATA QUALITY AUDITOR - SUMMARY REPORT FOR: %s\n", basename(csv_path)))
cat(sprintf("========================================================================\n\n"))

# Read data
data <- read.csv(csv_path, stringsAsFactors = FALSE)
n_rows <- nrow(data)
n_cols <- ncol(data)

cat(sprintf("Dataset loaded successfully: %d rows, %d columns.\n\n", n_rows, n_cols))

if (n_rows == 0) {
  cat("Error: The loaded dataset is empty (0 rows). No validation can be performed.\n")
  quit(status = 1)
}

# 1. Automatic Column Discovery
numeric_cols <- c()
categorical_cols <- c()
candidate_keys <- c()

for (col_name in colnames(data)) {
  col_data <- data[[col_name]]
  n_unique <- length(unique(col_data))
  
  # Check if numeric
  is_num <- is.numeric(col_data) || is.integer(col_data)
  is_all_int <- is_num && all(col_data == round(col_data), na.rm = TRUE)
  is_float <- is_num && !is_all_int
  
  if (is_num) {
    # It is a float (e.g. account balance), OR it is an integer that is not acting as a unique ID
    if (is_float || (n_unique > 1 && n_unique < n_rows * 0.95)) {
      numeric_cols <- c(numeric_cols, col_name)
    }
  }
  
  # Check if categorical (moderate cardinality, and has group replication)
  is_char_or_factor <- is.character(col_data) || is.factor(col_data)
  is_low_card_int <- is_all_int && n_unique >= 2 && n_unique <= 5
  
  if ((is_char_or_factor || is_low_card_int) && n_unique >= 2 && n_unique <= 15) {
    # Ensure there is replication (not a unique name or ID column)
    if (n_unique < n_rows * 0.90) {
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

cat("--- Column Classifications ---\n")
cat(sprintf("Numeric Candidates:     %s\n", paste(numeric_cols, collapse = ", ")))
cat(sprintf("Categorical Candidates: %s\n", paste(categorical_cols, collapse = ", ")))
cat(sprintf("Candidate Join Keys:    %s\n\n", paste(candidate_keys, collapse = ", ")))

# 2. Join Key Validation (Halucination & Cartesian Guard)
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
      cat(sprintf("[FAIL] Key '%s' contains duplicates!\n", key))
      cat(sprintf("       - Duplicate Count: %d rows (%.2f%%)\n", n_duplicates, dup_rate * 100))
      cat(sprintf("       - DANGER: Joining on this key will cause a Cartesian product (row duplication)!\n"))
    } else if (null_rate > 0.05) {
      cat(sprintf("[WARNING] Key '%s' contains a high number of nulls!\n", key))
      cat(sprintf("          - Null Count: %d rows (%.2f%%)\n", n_null, null_rate * 100))
    } else {
      cat(sprintf("[PASS] Key '%s' is clean.\n", key))
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
  col_data <- data[[col_name]]
  n_unique <- length(unique(col_data))
  
  if (n_unique == 1) {
    mode_val <- unique(col_data)
    cat(sprintf("[WARNING] Column '%s' is completely constant! All %d rows have the value '%s'.\n", col_name, n_rows, mode_val))
    cat(sprintf("          - Check if this is an unintended default or a join/filtering error.\n"))
    coalesce_warnings <- coalesce_warnings + 1
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
      }
    }
  }
}
if (coalesce_warnings == 0) {
  cat("[PASS] No severe value coalescing or mode collapse detected.\n\n")
} else {
  cat("\n")
}

# 4. ANOVA Audit (Data Replication Check)
cat("--- ANOVA Audit (Replication Check) ---\n")
anova_tested <- FALSE
if (length(numeric_cols) > 0 && length(categorical_cols) > 0) {
  for (num in numeric_cols) {
    for (cat in categorical_cols) {
      # Ensure categorical column has at least 2 categories and numeric has enough values
      group_counts <- table(data[[cat]])
      if (length(group_counts) >= 2 && min(group_counts) >= 2) {
        # Run ANOVA
        fit <- aov(data[[num]] ~ factor(data[[cat]]))
        aov_summary <- summary(fit)
        
        # Extract F-statistic and p-value
        f_val <- aov_summary[[1]]["factor(data[[cat]])", "F value"]
        p_val <- aov_summary[[1]]["factor(data[[cat]])", "Pr(>F)"]
        
        if (!is.null(p_val) && !is.na(p_val)) {
          anova_tested <- TRUE
          # Check for anomaly (identical means across groups, p-value ~ 1.0)
          # A p-value of exactly 1.0 or very close to it (e.g. > 0.999) with F close to 0
          # is highly unnatural and suggests the same values were cloned across groups.
          if (p_val > 0.999 && (is.na(f_val) || f_val < 1e-4)) {
            cat(sprintf("[FAIL] ANOVA anomaly on '%s' grouped by '%s'!\n", num, cat))
            cat(sprintf("       - p-value:     %.6f (identical group distributions)\n", p_val))
            cat(sprintf("       - F-statistic: %.6f\n", ifelse(is.na(f_val), 0, f_val)))
            cat(sprintf("       - DANGER: This indicates the numeric values are perfectly cloned across categories. Check for a cross-join or incorrect merge!\n"))
          } else {
            cat(sprintf("[PASS] ANOVA for '%s' grouped by '%s':\n", num, cat))
            cat(sprintf("       - p-value:     %.6f\n", p_val))
            cat(sprintf("       - F-statistic: %.4f\n", ifelse(is.na(f_val), 0, f_val)))
            if (p_val < 0.05) {
              cat(sprintf("       - Result: Group means are statistically significant (healthy distribution variance).\n"))
            } else {
              cat(sprintf("       - Result: No statistically significant difference in means, but variance is naturally distributed.\n"))
            }
          }
        }
      }
    }
  }
}

if (!anova_tested) {
  cat("No suitable numeric-categorical pairs found for ANOVA testing.\n\n")
} else {
  cat("\n")
}

# 5. Visualization Generation
file_base <- tools::file_path_sans_ext(basename(csv_path))
dir.create("gen", showWarnings = FALSE)
plot_file <- file.path("gen", paste0(file_base, "_validation_plot.png"))
cat("--- Visualizations ---\n")
if (length(numeric_cols) > 0 && length(categorical_cols) > 0) {
  # Choose the first numeric and first categorical column to plot
  num_plot <- numeric_cols[1]
  cat_plot <- categorical_cols[1]
  
  png(plot_file, width = 800, height = 600)
  # Set layout margins to prevent category labels from getting cut off
  par(mar = c(8, 4, 4, 2))
  boxplot(data[[num_plot]] ~ factor(data[[cat_plot]]),
          main = paste("Distribution of", num_plot, "by", cat_plot),
          xlab = cat_plot,
          ylab = num_plot,
          col = rainbow(length(unique(data[[cat_plot]]))),
          las = 2) # rotate category labels if long
  dev.off()
  cat(sprintf("[SAVED] Boxplot of '%s' by '%s' saved to '%s'.\n\n", num_plot, cat_plot, plot_file))
} else if (length(numeric_cols) >= 2) {
  # Plot the first two numeric columns against each other
  num1 <- numeric_cols[1]
  num2 <- numeric_cols[2]
  
  png(plot_file, width = 800, height = 600)
  plot(data[[num1]], data[[num2]],
       main = paste("Relationship between", num1, "and", num2),
       xlab = num1,
       ylab = num2,
       pch = 19,
       col = "darkblue")
  dev.off()
  cat(sprintf("[SAVED] Scatterplot of '%s' vs '%s' saved to '%s'.\n\n", num1, num2, plot_file))
} else {
  cat("Insufficient numeric or categorical columns to generate boxplots or scatterplots.\n\n")
}

cat("========================================================================\n")
cat("AUDIT COMPLETE\n")
cat("========================================================================\n")
