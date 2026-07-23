---
name: sql-auditor
description: >-
  Guides the agent on retrieving date-partitioned customer persona data from
  Snowflake and running the R-based multivariate statistical data quality auditor
  (featuring key duplicates, multicollinearity, MANOVA, K-Means, and log-normality RT checks).
---

# Snowflake SQL & R Statistical Quality Auditor

## Overview
This skill outlines the process for retrieving customer personas datasets from Snowflake and executing the R-based statistical auditor. The auditor validates data integrity, identifies query join bugs, groups records into customer personas using K-Means, and generates a scientific experiment report.

## Dependencies
* **Snow CLI** (v3.20.0 or higher) - For query execution.
* **R Environment** - Loaded with CRAN libraries `car` and `cluster` (managed via `renv`).

## Quick Start

### 1. Data Retrieval
To fetch the live date-filtered customer personas dataset:
```bash
npm run fetch:sql
```
This runs `src/sql/snowflake/fetch_snowflake_data.sh`, which loads the query from `src/sql/snowflake/customer_personas_query.sql` and writes the output to `gen/customer_orders_nominal.csv`.

### 2. Audit Execution
To audit the default nominal dataset and generate the visualization dashboard and Markdown report:
```bash
npm run validate:sql
```
To run the auditor on a custom dataset:
```bash
npm run validate:sql <path_to_csv>
```
Output files are written to `gen/` prefixed with the CSV filename:
* **PCA Dashboard Plot**: `gen/<file>_validation_plot.png`
* **Scientific Experiment Report**: `gen/<file>_audit_report.md`

---

## Statistical Methodology Guidelines

When analyzing user performance, latency, or response-time (RT) data (e.g. `MAX_SHIP_DELAY`):
1. **Outlier Filtering**: Apply a three-standard-deviation (3-SD) exclusion rule to filter extreme trial latencies (Nature Scientific Reports, s41598-024-58300-7).
2. **Log-Transformation**: Since reaction time data has a characteristic positive skewness, apply a natural log-transformation `log(RT + 1)` before running parametric ANOVA/MANOVA checks to satisfy normality assumptions.
3. **Multicollinearity Checks**: Compute pairwise correlations. Flag any correlation $\ge 0.999$ as a collinearity bug (indicates redundant math or duplicate joins).
4. **Replication Audits**: Grouped MANOVA/ANOVA p-values equal to `1.0` indicate identical group distributions. Flag this as a cross-join replication bug.
5. **Experimental Controls**: Recommend logging client-side browser WebGL acceleration (`hardware_status` software-fallback checks) and high-resolution event click times (`inter_action_delay` using `performance.now()`) to isolate device-induced latency noise from true user hesitation (PMC12960822).

## Common Mistakes
* **Omiting Log-Transforms on Latencies**: Running raw parametric tests on skewed response times leads to high Type I error rates. Always log-transform.
* **Corrupted Join Keys**: Ensure candidate keys (ends in `id` or `key`) are audited for duplicate rows to prevent Cartesian product expansions in joins.
* **Hardcoded Credentials**: Always load credentials from `.env` in the fetch script rather than hardcoding accounts or passwords.
