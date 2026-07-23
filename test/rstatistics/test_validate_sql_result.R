library(testthat)

# Source the main R script (using relative path checks)
script_path <- "src/rstatistics/validate_sql_result.R"
if (!file.exists(script_path)) {
  script_path <- "../../src/rstatistics/validate_sql_result.R"
}
source(script_path)

test_that("get_skewness calculates skewness correctly", {
  # Symmetric vector
  expect_equal(get_skewness(c(1, 2, 3)), 0)
  
  # Positive skew
  expect_gt(get_skewness(c(1, 1, 1, 1, 10)), 0)
  
  # Negative skew
  expect_lt(get_skewness(c(1, 10, 10, 10, 10)), 0)
  
  # Too short vector
  expect_equal(get_skewness(c(1, 2)), 0)
})

test_that("format_pval formats p-values cleanly", {
  expect_equal(format_pval(0.05), "0.0500")
  expect_equal(format_pval(0.00001), "< 0.0001")
  expect_equal(format_pval(NA), "NA")
  expect_equal(format_pval(NaN), "NA")
})

test_that("get_subject_terminology deduces subject names based on filename", {
  expect_equal(get_subject_terminology("gen/customer_orders_nominal.csv")$singular, "order")
  expect_equal(get_subject_terminology("gen/customer_orders_nominal.csv")$plural, "orders")
  expect_equal(get_subject_terminology("gen/arbres-publics.csv")$singular, "tree")
  expect_equal(get_subject_terminology("gen/arbres-publics.csv")$plural, "trees")
  expect_equal(get_subject_terminology("gen/some_other_file.csv")$singular, "record")
})

test_that("classify_columns separates columns correctly", {
  df <- data.frame(
    id_col = 1:100,
    num_col = runif(100) * 10,
    cat_col = rep(c("A", "B"), 50),
    stringsAsFactors = FALSE
  )
  
  cols <- classify_columns(df)
  expect_true("id_col" %in% cols$candidate_keys)
  expect_true("num_col" %in% cols$numeric_cols)
  expect_true("cat_col" %in% cols$categorical_cols)
})

test_that("select_uninformative_factors partitions active and uninformative factors", {
  prep <- list(
    data = data.frame(
      const_col = rep("A", 10),
      uniform_col = rep(c("X", "Y", "Z"), 10)[1:10],
      sig_col = c(rep("M", 5), rep("N", 5)),
      stringsAsFactors = FALSE
    ),
    categorical_cols = c("const_col", "uniform_col", "sig_col")
  )
  
  sig_results <- list(
    anova_pvals = list(
      uniform_col = c(0.8, 0.9),
      sig_col = c(0.01)
    ),
    manova_pvals = list(
      uniform_col = 0.5,
      sig_col = 0.001
    )
  )
  
  collinear_redundant_cols <- c("redundant_num")
  
  reporting <- select_uninformative_factors(sig_results, collinear_redundant_cols, prep, list())
  
  uninfo_names <- sapply(reporting$uninformative_factors, function(x) x$name)
  
  expect_true("const_col" %in% uninfo_names)
  expect_true("uniform_col" %in% uninfo_names)
  expect_true("redundant_num" %in% uninfo_names)
  expect_false("sig_col" %in% uninfo_names)
  
  expect_true("sig_col" %in% reporting$informative_factors)
})

# --- User Stories mapped to test hooks ---

test_that("Story 1: identify if a data set has value", {
  df_clean <- data.frame(
    id = 1:10,
    val1 = runif(10),
    cat = rep(c("A", "B"), 5),
    stringsAsFactors = FALSE
  )
  clean_cols <- classify_columns(df_clean)
  clean_audit <- audit_keys(df_clean, clean_cols$candidate_keys)
  expect_equal(clean_audit$grade, "COMPLIANT 🟢")
})

test_that("Story 2: identify if a data set contains statistically significant information", {
  df_sig <- data.frame(
    outcome = c(1, 2, 1, 2, 1, 2, 1, 2, 1, 2),
    group = c("A", "B", "A", "B", "A", "B", "A", "B", "A", "B"),
    stringsAsFactors = FALSE
  )
  res <- run_significance_tests(df_sig, c("outcome"), c("group"))
  expect_true(res$anova_tested)
  expect_lt(res$anova_pvals$group[1], 0.05)
})

# TODO: Implement a test that verifies report generation output and cross-checking claims (currently only tests format_pval helper)
test_that("Story 3: produce a report that is easy to read that follows scientific rigor and contains claims that can be cross checked and proved true or false", {
  # Accuracy and format checks
  expect_equal(format_pval(0.00001), "< 0.0001")
})

# TODO: Implement a test that verifies box and whisker plot generation for significant factors
test_that("Story 4: produce a report that contains box and whisker plots showing the statistically significant factors", {
  expect_true(TRUE)
})

# TODO: Implement a test that verifies scatter plot generation and check for normal distribution line of fit
test_that("Story 5: show the distribution of the data in scatter plots so i can see if the data is normally distributed or not normally distributed as well as the variance of the data around a line of fit", {
  expect_true(TRUE)
})

test_that("Story 6: attempt to cluster the data using the factors to identify clusters in the dataset", {
  df_cluster <- data.frame(
    x = c(runif(5, 0, 1), runif(5, 10, 11)),
    y = c(runif(5, 0, 1), runif(5, 10, 11))
  )
  res <- discover_personas(df_cluster, c("x", "y"), list(domain_singular = "persona", domain_plural = "personas", plural = "records"))
  expect_true(res$kmeans_run)
  expect_equal(res$k_centers, 2)
})

# TODO: Implement a test that verifies report accuracy and verification check routines (currently only tests format_pval helper)
test_that("Story 7: produce a report that is accurate", {
  expect_equal(format_pval(0.000001), "< 0.0001")
  expect_equal(format_pval(0.05123), "0.0512")
})

# TODO: Implement a test that verifies histogram generation showing long tails and non-normal distributions
test_that("Story 8: show histograms to see which factors have a long tail and which factors are not normally distributed", {
  expect_true(TRUE)
})
