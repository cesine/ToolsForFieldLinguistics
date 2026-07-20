# Pull Request Description: Advanced SQL Quality Auditor, MANOVA/ANOVA Validation, and K-Means Persona Dashboard

## Overview of Changes
This PR introduces database validation templates, multivariate statistical checks, and automated research report generation to evaluate query output integrity and group customer behavior datasets. 

### 1. SQL Querying & Retrieval (`src/sql/snowflake/`)
* **[customer_personas_query.sql](file:///Users/gchiodo/gitgina/ToolsForFieldLinguistics/src/sql/snowflake/customer_personas_query.sql)**: Added a multi-table query that joins customer segments, locations, regions, and aggregates lineitem transaction metrics (total prices, delays, counts, and discounts).
* **[fetch_snowflake_data.sh](file:///Users/gchiodo/gitgina/ToolsForFieldLinguistics/src/sql/snowflake/fetch_snowflake_data.sh)**: Updated the retrieval pipeline to feed SQL directly from the `.sql` template files using `snow sql -f` with temporary connection credentials.

### 2. Multivariate R Data Quality Auditor (`src/rstatistics/validate_sql_result.R`)
Upgraded the R validator with automated statistical tests using R packages `car` and `cluster`:
* **Dynamic Quantile Binning**: Bins high-variance numeric columns into `Low`, `Medium`, and `High` groups to test their categorical influence on behavior.
* **Multicollinearity Checks**: Computes pairwise correlation matrices. Flags any correlation $\ge 0.999$ as a collinearity bug (typically indicating redundant mathematical logic or duplicate table joins).
* **MANOVA & ANOVA Audits**: Evaluates joint outcomes across categories (using Pillai's trace). Flags cross-join anomalies (where $p$-value = 1.0, signifying cloned row replication). Fits are wrapped in `tryCatch` to handle rank-deficient residual covariance matrices gracefully on small datasets.
* **Response-Time (RT) Preprocessing**:
  * **Outlier Removal**: Excludes data points outside 3 standard deviations (3-SD) of the mean (e.g. `MAX_SHIP_DELAY` outliers).
  * **Log-Transformation**: Applies natural log-transformations `log(RT + 1)` to address the characteristic positive skewness of delay metrics, satisfying normal assumptions for parametric ANOVA modeling.
* **K-Means Persona Discovery**: Clusters normalized transactional features into $k=3$ distinct behavioral profiles.
* **Visualization Engine**: Generates a 2x2 dashboard containing PCA cluster spacing, correlation heatmaps, persona sizes, and metric boxplots.
* **Scientific Lab Report Generator**: Auto-generates a Markdown report (`gen/<file>_audit_report.md`) detailing the experiment's abstract, introduction, methodology, results, and discussion.

### 3. Appendix Reference Scripts
Added and referenced two client-side diagnostic scripts to control for behavioral latencies:
* **Appendix A (GPU Acceleration)**: A WebGL check script to identify browser environments running software rasterizers (e.g. SwiftShader) vs. hardware GPUs to flag performance-induced delay noise.
* **Appendix B (Inter-Action Delays)**: A high-resolution timestamp event listener (`performance.now()`) to track exact millisecond intervals between clicks to audit hesitation patterns and user fatigue.

---

## Why these changes were made (References & Prompts)
* **Outlier & Skewness Adjustments**: Adheres to the methodological recommendations in **Nature Scientific Reports (s41598-024-58300-7)** regarding reaction/response-time skewed distributions and 3-SD outlier filtering.
* **Intertemporal Choice & Hesitation**: Follows experimental considerations from **PMC12960822** for collecting latency profiles to differentiate user profiles.
* **Academic Writing Standards**: The auto-generated reports follow academic formatting specifications based on the **Sheffield University Lab Report Guidelines** and **Calgary HCI assignment guidelines**.

---

## Future TODOs (Before Merging the PR)
The following tasks are recommended to finalize before merging this PR:
1. **[ ] Programmatic Cluster Count ($k$) Estimation**: Implement Elbow method or Silhouette coefficient calculations inside the R script to dynamically estimate the optimal cluster count $k$ instead of relying on the static $k=3$ heuristic.
2. **[ ] Connect WebGL GPU check to Datasets**: Integrate the client-side WebGL script (Appendix A) into the trial collections so that a `hardware_status` column is logged, allowing the R auditor to filter/separate software-rendered delays from hardware-gpu trials.
3. **[ ] GA4 Inter-Action Delay Logging**: Map the high-resolution inter-action delay tracking (Appendix B) to custom dimensions in Google Analytics 4 (GA4) to enable bulk behavioural profiling.
4. **[ ] GitHub Actions CI check**: Add a CI workflow that runs `npm run validate:sql` on pull requests modifying SQL templates, rejecting merges if duplicate keys, collinearity, or replication errors are detected.
