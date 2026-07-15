#!/usr/bin/env Rscript

# =====================================================================
# R SQL Data Quality Auditor & Validator (Advanced Version)
# Performs automated column classification, join key audits,
# value coalescing warnings, collinearity checks, ANOVA/MANOVA group checks,
# K-Means customer persona discovery, and PCA visualization dashboards.
#
# Usage: Rscript src/rstatistics/validate_sql_result.R <path_to_csv>
# =====================================================================

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1) {
  default_path <- "gen/customer_orders_happy.csv"
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
    # It is a float (e.g. balance), OR it is an integer that is not acting as a unique ID
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

# --- Dynamic Discretization (Histogram Quantile Binning) ---
# For numeric columns with high variance, bin them into Low, Medium, High categories.
binned_cols <- c()
for (num_col in numeric_cols) {
  col_data <- data[[num_col]]
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
    data[[bin_name]] <- cut(col_data, breaks = breaks, include.lowest = TRUE, labels = c("Low", "Medium", "High"))
    categorical_cols <- c(categorical_cols, bin_name)
    binned_cols <- c(binned_cols, bin_name)
  }
}

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
  # Exclude binned columns from mode collapse warnings
  if (grepl("_BIN$", col_name)) next
  
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

# 4. Multicollinearity Audit (SQL Join & Math Bug Guard)
cat("--- Multicollinearity Audit ---\n")
collinearity_detected <- FALSE
if (length(numeric_cols) >= 2) {
  # Calculate pairwise correlations
  cor_matrix <- cor(data[numeric_cols], use = "pairwise.complete.obs")
  for (i in 1:(length(numeric_cols)-1)) {
    for (j in (i+1):length(numeric_cols)) {
      c_val <- cor_matrix[i, j]
      if (!is.na(c_val) && abs(c_val) >= 0.999) {
        cat(sprintf("[FAIL] Multicollinearity bug detected between '%s' and '%s'! (Correlation = %.4f)\n", 
                    numeric_cols[i], numeric_cols[j], c_val))
        cat("       - DANGER: Perfectly correlated numeric columns indicate duplicate joins or redundant SQL computations.\n")
        collinearity_detected <- TRUE
      }
    }
  }
}
if (!collinearity_detected) {
  cat("[PASS] No severe multicollinearity or redundant numeric columns detected.\n\n")
} else {
  cat("\n")
}

# 5. ANOVA & MANOVA Audit (Multivariate Quality Check)
cat("--- ANOVA & MANOVA Audit (Replication Check) ---\n")
anova_tested <- FALSE
manova_tested <- FALSE

# Fit MANOVA if multiple numeric outcomes exist
if (length(numeric_cols) >= 2 && length(categorical_cols) > 0) {
  for (cat_col in categorical_cols) {
    # Skip checking a binned column against its own parent numeric variable (will yield trivial p-value = 0)
    is_self_bin <- FALSE
    for (num_col in numeric_cols) {
      if (cat_col == paste0(num_col, "_BIN")) {
        is_self_bin <- TRUE
        break
      }
    }
    if (is_self_bin) next
    
    group_counts <- table(data[[cat_col]])
    if (length(group_counts) >= 2 && min(group_counts) >= 2) {
      Y <- as.matrix(data[numeric_cols])
      group <- factor(data[[cat_col]])
      
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
          
          if (!is.na(pval) && pval > 0.999 && (is.na(fval) || fval < 1e-4)) {
            cat(sprintf("[FAIL] MANOVA anomaly on numeric variables grouped by '%s'!\n", cat_col))
            cat(sprintf("       - p-value:     %.6f (identical multivariate distributions)\n", pval))
            cat(sprintf("       - F-statistic: %.6f\n", ifelse(is.na(fval), 0, fval)))
            cat(sprintf("       - DANGER: Combined numeric metrics are perfectly replicated across categories. Check for a cross-join or incorrect merge!\n"))
          } else {
            cat(sprintf("[PASS] MANOVA on numeric metrics grouped by '%s':\n", cat_col))
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
      if (cat == paste0(num, "_BIN")) next
      
      group_counts <- table(data[[cat]])
      if (length(group_counts) >= 2 && min(group_counts) >= 2) {
        fit <- aov(data[[num]] ~ factor(data[[cat]]))
        aov_summary <- summary(fit)
        
        f_val <- aov_summary[[1]]["factor(data[[cat]])", "F value"]
        p_val <- aov_summary[[1]]["factor(data[[cat]])", "Pr(>F)"]
        
        if (!is.null(p_val) && !is.na(p_val)) {
          anova_tested <- TRUE
          if (p_val > 0.999 && (is.na(f_val) || f_val < 1e-4)) {
            cat(sprintf("[FAIL] ANOVA anomaly on '%s' grouped by '%s'!\n", num, cat))
            cat(sprintf("       - p-value:     %.6f (identical group distributions)\n", p_val))
            cat(sprintf("       - F-statistic: %.6f\n", ifelse(is.na(f_val), 0, f_val)))
            cat(sprintf("       - DANGER: Numeric values are perfectly cloned across categories. Check for a cross-join or incorrect merge!\n"))
          } else {
            cat(sprintf("[PASS] ANOVA for '%s' grouped by '%s':\n", num, cat))
            cat(sprintf("       - p-value:     %.6f\n", p_val))
            cat(sprintf("       - F-statistic: %.4f\n", ifelse(is.na(f_val), 0, f_val)))
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
if (length(numeric_cols) >= 2) {
  # Scale numeric variables
  scaled_data <- scale(data[numeric_cols])
  scaled_data[is.nan(scaled_data)] <- 0
  
  # Heuristic for cluster counts:
  # Action Item: Programmatic Elbow / Silhouette optimization
  k_centers <- 3
  
  km_fit <- tryCatch({
    kmeans(scaled_data, centers = k_centers, nstart = 25)
  }, error = function(e) { NULL })
  
  if (!is.null(km_fit)) {
    kmeans_run <- TRUE
    data$KMeans_Cluster <- as.factor(km_fit$cluster)
    cat(sprintf("[SUCCESS] Discovered %d customer order personas using K-Means.\n", k_centers))
    cl_tbl <- table(data$KMeans_Cluster)
    for (cl_id in names(cl_tbl)) {
      cat(sprintf("          - Persona Cluster %s: %d orders (%.2f%%)\n", 
                  cl_id, cl_tbl[cl_id], 100 * cl_tbl[cl_id] / n_rows))
    }
    cat("\n")
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
  pca_fit <- prcomp(scaled_data)
  var_exp <- round(100 * pca_fit$sdev^2 / sum(pca_fit$sdev^2), 1)
  
  plot(pca_fit$x[,1], pca_fit$x[,2],
       col = rainbow(k_centers)[as.numeric(data$KMeans_Cluster)],
       pch = 19, cex = 1.2,
       main = "Customer Personas (PCA Cluster Space)",
       xlab = paste0("PC1 (", var_exp[1], "% variance)"),
       ylab = paste0("PC2 (", var_exp[2], "% variance)"))
  grid()
  legend("topright", legend = paste("Persona", 1:k_centers),
         col = rainbow(k_centers), pch = 19, cex = 0.8)
  
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
          main = "Persona Cluster Sizes",
          xlab = "Persona ID", ylab = "Number of Orders",
          col = "lightgreen", border = "white")
  
  # Panel 4: Boxplot of O_TOTALPRICE by Persona Cluster
  boxplot(data[[numeric_cols[1]]] ~ data$KMeans_Cluster,
          main = paste(numeric_cols[1], "by Persona"),
          xlab = "Persona ID", ylab = numeric_cols[1],
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

cat("========================================================================\n")
cat("AUDIT COMPLETE\n")
cat("========================================================================\n")
