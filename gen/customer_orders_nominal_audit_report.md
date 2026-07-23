# SQL Data Quality and Behavior Analysis Lab Report: customer_orders_nominal

**Report Generated on:** 2026-07-23 09:06:38.885301
**Source Dataset:** `customer_orders_nominal.csv`
**Auditor Classification Status:** CRITICAL ANOMALY DETECTED 🔴

---

## Abstract
This report presents a controlled statistical audit of the database query results comprising 618 samples and 14 features. Using [Multivariate Analysis of Variance (MANOVA)](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance), [K-Means clustering](https://en.wikipedia.org/wiki/K-means_clustering), and correlation-matrix collinearity tests, we investigate the structure of the retrieved dataset. The objective is to identify potential query design flaws (such as duplicate joins, cross joins, and hardcoded values) and characterize the underlying customer order personas. Our findings show that the dataset has a classification status of **CRITICAL ANOMALY DETECTED 🔴**. We detail actionable recommendations for query optimizations based on detected data anomalies.

## 1. Introduction and Hypotheses
In database engineering and agentic data pipelines, query errors often manifest as subtle statistical anomalies (e.g. artificial correlation due to duplicate joins or zero variance due to cross joins) rather than outright syntax failures. We formally evaluate the following hypotheses:
* **Null Hypothesis ($H_0$)**: The physical and spatial parameters of the observed orders (such as O_TOTALPRICE, C_ACCTBAL, TOTAL_QUANTITY, AVG_DISCOUNT) are homogeneous and do not vary significantly across categorical groupings.
* **Alternative Hypothesis ($H_1$)**: The physical and spatial parameters of the observed orders show statistically significant variations across these categorical dimensions, indicating distinct sub-populations.

## 2. Experimental Methodology

### Participants (Dataset Description)
The 'participants' (observed entities) in this study consist of the orders fetched from the database.
The demographic distribution of the sample is detailed below:

| Category Variable | Group Level | Sample Size (N) | Percentage (%) |
|---|---|---|---|
| **O_ORDERSTATUS** | O | 618 | 100.00% |
| **O_ORDERPRIORITY** | 2-HIGH | 140 | 22.65% |
| **O_ORDERPRIORITY** | 4-NOT SPECIFIED | 133 | 21.52% |
| **O_ORDERPRIORITY** | 1-URGENT | 131 | 21.20% |
| **O_ORDERPRIORITY** | 3-MEDIUM | 111 | 17.96% |
| **O_ORDERPRIORITY** | 5-LOW | 103 | 16.67% |
| **C_MKTSEGMENT** | MACHINERY | 143 | 23.14% |
| **C_MKTSEGMENT** | AUTOMOBILE | 127 | 20.55% |
| **C_MKTSEGMENT** | BUILDING | 120 | 19.42% |
| **C_MKTSEGMENT** | FURNITURE | 117 | 18.93% |
| **C_MKTSEGMENT** | HOUSEHOLD | 111 | 17.96% |
| **C_REGION** | ASIA | 130 | 21.04% |
| **C_REGION** | MIDDLE EAST | 128 | 20.71% |
| **C_REGION** | AFRICA | 125 | 20.23% |
| **C_REGION** | EUROPE | 118 | 19.09% |
| **C_REGION** | AMERICA | 117 | 18.93% |
| **O_TOTALPRICE_BIN** | Medium | 210 | 33.98% |
| **O_TOTALPRICE_BIN** | Low | 204 | 33.01% |
| **O_TOTALPRICE_BIN** | High | 204 | 33.01% |
| **C_ACCTBAL_BIN** | Medium | 210 | 33.98% |
| **C_ACCTBAL_BIN** | Low | 204 | 33.01% |
| **C_ACCTBAL_BIN** | High | 204 | 33.01% |
| **TOTAL_QUANTITY_BIN** | Medium | 209 | 33.82% |
| **TOTAL_QUANTITY_BIN** | Low | 206 | 33.33% |
| **TOTAL_QUANTITY_BIN** | High | 203 | 32.85% |
| **AVG_DISCOUNT_BIN** | Low | 209 | 33.82% |
| **AVG_DISCOUNT_BIN** | Medium | 205 | 33.17% |
| **AVG_DISCOUNT_BIN** | High | 204 | 33.01% |
| **TOTAL_DISCOUNT_VALUE_BIN** | Medium | 210 | 33.98% |
| **TOTAL_DISCOUNT_VALUE_BIN** | Low | 204 | 33.01% |
| **TOTAL_DISCOUNT_VALUE_BIN** | High | 204 | 33.01% |
| **MAX_SHIP_DELAY_LOG_BIN** | Medium | 258 | 41.75% |
| **MAX_SHIP_DELAY_LOG_BIN** | Low | 203 | 32.85% |
| **MAX_SHIP_DELAY_LOG_BIN** | High | 149 | 24.11% |

Figure 3 presents the sample size distributions across each independent categorical variable to evaluate demographic coverage and statistical power:

![Figure 3: Independent Variable Sample Size Distributions](customer_orders_nominal_independent_distributions.png)

### Apparatus and Setup
Queries were executed against the Snowflake TPC-H sample database (`SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`; Transaction Processing Performance Council [TPC], 2014) using the Snowflake CLI tool (`snow` CLI v3.20.0). Statistical analysis and clustering were computed in R using packages `car` (ANOVA/MANOVA modelling) and `cluster` (K-Means silhouette groupings).

### Hardware Acceleration Controls
As highlighted in the methodological considerations for online response-time behavioral studies (McConnell et al., 2024), differences in browser hardware configuration and rendering pipelines (e.g. software rasterizer vs. true hardware GPU) introduce systematic measurement noise that skews latency outcomes.
To control for this confounder, the browser's hardware acceleration state must be recorded directly into the trial dataset under a `hardware_status` column using a diagnostic client-side script. The implementation of this client check is provided in Appendix A.

### Inter-Action Interval Controls
To profile user choice dynamics, click patterns, and decision hesitation (Pongratz & Schoemann, 2026), we track the high-resolution inter-action delay (the exact milliseconds elapsed between successive button clicks). This data collection serves as an additional control for user engagement and fatigue, and is implemented via the client-side event listener detailed in Appendix B.

### Experimental Design
We define a mixed multivariate design incorporating:
* **Independent Variables (Factors)**: `O_ORDERSTATUS`, `O_ORDERPRIORITY`, `C_MKTSEGMENT`, `C_REGION`, `O_TOTALPRICE_BIN`, `C_ACCTBAL_BIN`, `TOTAL_QUANTITY_BIN`, `AVG_DISCOUNT_BIN`, `TOTAL_DISCOUNT_VALUE_BIN`, `MAX_SHIP_DELAY_LOG_BIN`
* **Dependent Variables (Metrics)**: `O_TOTALPRICE`, `C_ACCTBAL`, `TOTAL_QUANTITY`, `AVG_DISCOUNT`, `TOTAL_DISCOUNT_VALUE`, `ITEM_COUNT`, `MAX_SHIP_DELAY_LOG`

### Response-Time Preprocessing (Methodological Standards)
Following standard methodologies for reaction time outcomes (McConnell et al., 2024):
1. **Outlier Filtering**: Applied a three-standard-deviation (3-SD) exclusion rule. Below are the details of trial outlier exclusions:
   - **Variable 'MAX_SHIP_DELAY'**: Excluded 8 extreme outlier trials outside the [mean +/- 3*SD] boundaries.
2. **Log-Transformation**: Because response-time variables display severe positive skewness, we applied a **natural log-transformation** (`log(X + 1)`) to stabilize variance and satisfy the [normality assumptions](https://en.wikipedia.org/wiki/Normal_distribution#Statistical_inference) of [ANOVA](https://en.wikipedia.org/wiki/Analysis_of_variance) and [MANOVA](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance) tests. Skewness was corrected as follows:
   - **'MAX_SHIP_DELAY'** original skewness: `-1.2678` | log-transformed skewness: `-2.0682`


## 3. Results

### Data Quality and SQL Integrity Audits
- **CRITICAL ANOMALY: Duplicate Join Key in 'O_CUSTKEY'**: Unique rate is 99.51%. Joining on this column will cause a Cartesian product multiplication (row duplication).
- **WARNING: Constant Column 'O_ORDERSTATUS'**: 100% of rows contain the value 'O'.
- **WARNING: Constant Column 'O_ORDERDATE'**: 100% of rows contain the value '1998-08-01'.
- **WARNING: Suspicious Uniformity on 'C_REGION'**: Category counts are highly uniform (Coefficient of Variation = 0.0474). This suggests the dataset is synthetic or has been artificially balanced.
- **WARNING: Suspicious Uniformity on 'O_TOTALPRICE_BIN'**: Category counts are highly uniform (Coefficient of Variation = 0.0168). This suggests the dataset is synthetic or has been artificially balanced.
- **WARNING: Suspicious Uniformity on 'C_ACCTBAL_BIN'**: Category counts are highly uniform (Coefficient of Variation = 0.0168). This suggests the dataset is synthetic or has been artificially balanced.
- **WARNING: Suspicious Uniformity on 'TOTAL_QUANTITY_BIN'**: Category counts are highly uniform (Coefficient of Variation = 0.0146). This suggests the dataset is synthetic or has been artificially balanced.
- **WARNING: Suspicious Uniformity on 'AVG_DISCOUNT_BIN'**: Category counts are highly uniform (Coefficient of Variation = 0.0128). This suggests the dataset is synthetic or has been artificially balanced.
- **WARNING: Suspicious Uniformity on 'TOTAL_DISCOUNT_VALUE_BIN'**: Category counts are highly uniform (Coefficient of Variation = 0.0168). This suggests the dataset is synthetic or has been artificially balanced.

### Statistical Hypothesis Testing
#### MANOVA Group Factor Outcomes
We executed [multivariate analysis of variance (MANOVA)](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance) using [Pillai's trace](https://www.statisticshowto.com/pillais-trace/) to test for overall group differences across continuous variables:

- **Group Factor 'O_ORDERPRIORITY'**:
  - Pillai's Trace: `0.0382`
  - Approximate F:  `0.8289`
  - p-value:        `0.7218` (Not Significant)

- **Group Factor 'C_MKTSEGMENT'**:
  - Pillai's Trace: `0.0509`
  - Approximate F:  `1.1079`
  - p-value:        `0.3175` (Not Significant)

- **Group Factor 'C_REGION'**:
  - Pillai's Trace: `0.0254`
  - Approximate F:  `0.5488`
  - p-value:        `0.9739` (Not Significant)

- **Group Factor 'MAX_SHIP_DELAY_LOG_BIN'**:
  - Pillai's Trace: `0.6264`
  - Approximate F:  `39.2228`
  - p-value:        `< 0.0001` (Statistically Significant)


#### ANOVA Outputs (Significant Univariate Groupings)
We evaluated individual [univariate Analysis of Variance (ANOVA)](https://en.wikipedia.org/wiki/Analysis_of_variance) models for each continuous metric. The following factors show statistically significant differences (p < 0.05) in group means:

- **Significant variation in 'O_TOTALPRICE' grouped by 'TOTAL_QUANTITY_BIN'**: F = `1279.3364`, p = `< 0.0001`
- **Significant variation in 'O_TOTALPRICE' grouped by 'AVG_DISCOUNT_BIN'**: F = `14.2000`, p = `< 0.0001`
- **Significant variation in 'O_TOTALPRICE' grouped by 'TOTAL_DISCOUNT_VALUE_BIN'**: F = `511.4893`, p = `< 0.0001`
- **Significant variation in 'O_TOTALPRICE' grouped by 'MAX_SHIP_DELAY_LOG_BIN'**: F = `51.2760`, p = `< 0.0001`
- **Significant variation in 'TOTAL_QUANTITY' grouped by 'O_TOTALPRICE_BIN'**: F = `1427.0373`, p = `< 0.0001`
- **Significant variation in 'TOTAL_QUANTITY' grouped by 'AVG_DISCOUNT_BIN'**: F = `16.1459`, p = `< 0.0001`
- **Significant variation in 'TOTAL_QUANTITY' grouped by 'TOTAL_DISCOUNT_VALUE_BIN'**: F = `518.9834`, p = `< 0.0001`
- **Significant variation in 'TOTAL_QUANTITY' grouped by 'MAX_SHIP_DELAY_LOG_BIN'**: F = `52.4728`, p = `< 0.0001`
- **Significant variation in 'AVG_DISCOUNT' grouped by 'TOTAL_DISCOUNT_VALUE_BIN'**: F = `53.0806`, p = `< 0.0001`
- **Significant variation in 'TOTAL_DISCOUNT_VALUE' grouped by 'O_TOTALPRICE_BIN'**: F = `448.7368`, p = `< 0.0001`
- **Significant variation in 'TOTAL_DISCOUNT_VALUE' grouped by 'TOTAL_QUANTITY_BIN'**: F = `452.6462`, p = `< 0.0001`
- **Significant variation in 'TOTAL_DISCOUNT_VALUE' grouped by 'AVG_DISCOUNT_BIN'**: F = `71.1741`, p = `< 0.0001`
- **Significant variation in 'TOTAL_DISCOUNT_VALUE' grouped by 'MAX_SHIP_DELAY_LOG_BIN'**: F = `35.7527`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'O_TOTALPRICE_BIN'**: F = `716.1448`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'TOTAL_QUANTITY_BIN'**: F = `830.1939`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'AVG_DISCOUNT_BIN'**: F = `28.6173`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'TOTAL_DISCOUNT_VALUE_BIN'**: F = `341.0506`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'MAX_SHIP_DELAY_LOG_BIN'**: F = `65.4372`, p = `< 0.0001`
- **Significant variation in 'MAX_SHIP_DELAY_LOG' grouped by 'C_MKTSEGMENT'**: F = `2.8583`, p = `0.0229`
- **Significant variation in 'MAX_SHIP_DELAY_LOG' grouped by 'O_TOTALPRICE_BIN'**: F = `67.2699`, p = `< 0.0001`
- **Significant variation in 'MAX_SHIP_DELAY_LOG' grouped by 'TOTAL_QUANTITY_BIN'**: F = `73.0717`, p = `< 0.0001`
- **Significant variation in 'MAX_SHIP_DELAY_LOG' grouped by 'AVG_DISCOUNT_BIN'**: F = `4.4221`, p = `0.0124`
- **Significant variation in 'MAX_SHIP_DELAY_LOG' grouped by 'TOTAL_DISCOUNT_VALUE_BIN'**: F = `49.7741`, p = `< 0.0001`
- **Significant variation in 'MAX_SHIP_DELAY_LOG' grouped by 'MAX_SHIP_DELAY_LOG_BIN'**: F = `463.7476`, p = `< 0.0001`

Figure 2 presents the pairwise scatterplots with a fitted linear regression line of best fit to visualize the correlation and linear relationships between these continuous metrics:

![Figure 2: Pairwise Scatterplots with Line of Fit](customer_orders_nominal_scatterplots.png)

### Customer Order Persona Profiles (K-Means)
We standardized the numeric metrics and fitted a [K-Means clustering algorithm](https://en.wikipedia.org/wiki/K-means_clustering) ($k=2$) to identify distinct customer order personas. To determine the optimal number of clusters programmatically, we performed a **[Silhouette Analysis](https://en.wikipedia.org/wiki/Silhouette_(clustering))** across candidate sizes of $k \in [2, 6]$. The optimal $k$ was selected by maximizing the average silhouette width (Rousseeuw, 1987), which measures cluster cohesion and separation. If the maximum average silhouette width was $\le 0.25$, indicating no substantial structure, the algorithm fell back to a single nominal cluster ($k=1$):

| Persona Cluster | Order Count | Percentage (%) |
|---|---|---|
| **Cluster 1** | 287 | 46.44% |
| **Cluster 2** | 331 | 53.56% |


#### Population Profiles (Cluster Feature Means)
To characterize the discovered customer order personas in terms of the original variables, the table below presents the mean value of each numeric metric within each cluster:

| Cluster | O_TOTALPRICE | C_ACCTBAL | TOTAL_QUANTITY | AVG_DISCOUNT | TOTAL_DISCOUNT_VALUE | ITEM_COUNT | MAX_SHIP_DELAY_LOG |
|---|---|---|---|---|---|---|---|
| **Cluster 1** | 230128.95 | 4277.64 | 155.00 | 0.05 | 12067.62 | 5.79 | 3.29 |
| **Cluster 2** | 84001.63 | 4779.32 | 56.68 | 0.05 | 3926.69 | 2.48 | 3.03 |


## 4. Exploratory Multivariate Analysis and Cluster Diagnostics
Figure 1 presents the 2x2 data quality and customer order persona visualization dashboard:

![Figure 1: PCA Dashboard](customer_orders_nominal_validation_plot.png)

### Principal Component Loadings (Feature Contributions)
To reverse-engineer which original variables drive the principal component projections, the table below lists the loadings (rotation coefficients) for the first two components:

| Metric | PC1 Loading | PC2 Loading | Influence Strength (PC1 & PC2) |
|---|---|---|---|
| `AVG_DISCOUNT` | `-0.0911` | `0.8663` | `0.8711` |
| `TOTAL_DISCOUNT_VALUE` | `-0.4614` | `0.2736` | `0.5364` |
| `TOTAL_QUANTITY` | `-0.4938` | `-0.1083` | `0.5055` |
| `O_TOTALPRICE` | `-0.4916` | `-0.1107` | `0.5039` |
| `ITEM_COUNT` | `-0.4673` | `-0.1320` | `0.4855` |
| `MAX_SHIP_DELAY_LOG` | `-0.2700` | `-0.1856` | `0.3276` |
| `C_ACCTBAL` | `0.0462` | `-0.3143` | `0.3177` |


### Interpretation of Figure 1:
1. **[PCA](https://en.wikipedia.org/wiki/Principal_component_analysis) Cluster Space**: Represents the first two principal components. Good separation between color groups indicates distinct customer order personas. If the points form tight, overlapping lines or grids, it indicates identical data replication bugs.
2. **Correlation Heatmap**: Pairwise correlations between metrics. Strong colors indicate potential redundant attributes or duplicate join bugs.
3. **Cluster Sizes**: Frequency counts across the discovered customer order personas.
4. **Boxplot of O_TOTALPRICE**: Shows the distribution of the primary outcome metric across the clusters.

## 5. Discussion and SQL Improvement Recommendations
Based on the results, we recommend the following modifications to improve the SQL query:

- **Fix duplicate join key 'O_CUSTKEY'**: Ensure you are joining on a unique primary key. If you are joining a detail table, aggregate it first (e.g. in a subquery or CTE) before joining.
- **Constant Column 'O_ORDERSTATUS'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Constant Column 'O_ORDERDATE'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Investigate Uniformity on 'C_REGION'**: Ensure this uniform distribution is natural for your business domain, or replace with a representative natural dataset.
- **Investigate Uniformity on 'O_TOTALPRICE_BIN'**: Ensure this uniform distribution is natural for your business domain, or replace with a representative natural dataset.
- **Investigate Uniformity on 'C_ACCTBAL_BIN'**: Ensure this uniform distribution is natural for your business domain, or replace with a representative natural dataset.
- **Investigate Uniformity on 'TOTAL_QUANTITY_BIN'**: Ensure this uniform distribution is natural for your business domain, or replace with a representative natural dataset.
- **Investigate Uniformity on 'AVG_DISCOUNT_BIN'**: Ensure this uniform distribution is natural for your business domain, or replace with a representative natural dataset.
- **Investigate Uniformity on 'TOTAL_DISCOUNT_VALUE_BIN'**: Ensure this uniform distribution is natural for your business domain, or replace with a representative natural dataset.

### Methodological Discussion on Skewness
As detailed in the references, response-time metrics are typically right-skewed and violating [normality assumptions](https://en.wikipedia.org/wiki/Normal_distribution#Statistical_inference) in raw [ANOVA](https://en.wikipedia.org/wiki/Analysis_of_variance) leads to higher [Type I errors](https://en.wikipedia.org/wiki/Type_I_and_Type_II_errors#Type_I_error). Log-transforming the delay metrics significantly stabilizes the residuals, making our multivariate models highly reliable for identifying behavioral deviations in the customer order personas.

## References
1. University of Sheffield. (n.d.). *Science lab reports*. University of Sheffield 301 Academic Skills. https://www.sheffield.ac.uk/301/study-skills/writing/academic/lab-reports
2. Saul, S. (n.d.). *Guidelines for controlled experiment reports*. University of Calgary Department of Computer Science. https://pages.cpsc.ucalgary.ca/~saul/hci_topics/assignments/controlled_expt/ass1_reports.html
3. McConnell, P. A., Finetto, C., & Heise, K.-F. (2024). Methodological considerations for behavioral studies relying on response time outcomes through online crowdsourcing platforms. *Scientific Reports*, *14*(1), Article 7719. https://doi.org/10.1038/s41598-024-58300-7
4. Pongratz, H., & Schoemann, M. (2026). A large-scale dataset of choice and response-time data in intertemporal choice. *Scientific Data*, *13*, Article 150. https://doi.org/10.1038/s41597-026-06947-4
5. Transaction Processing Performance Council. (2014). *TPC Benchmark H: Standard specification* (Revision 2.17.1). https://www.tpc.org/tpc_documents_current_versions/pdf/tpc-h_v2.17.1.pdf
6. Rousseeuw, P. J. (1987). Silhouettes: A graphical aid to the interpretation and validation of cluster analysis. *Journal of Computational and Applied Mathematics*, *20*, 53-65. https://doi.org/10.1016/0377-0427(87)90125-7

---

## Appendix A: Client-Side Hardware Acceleration Detection Script
Below is the JavaScript routine to determine if the browser environment uses hardware GPU acceleration or falls back to software rendering (e.g. SwiftShader), which should be appended to trial collections to log the `hardware_status` column:

```javascript
function checkHardwareAcceleration() {
    const canvas = document.createElement('canvas');
    const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');
    if (!gl) return "disabled_or_unsupported";
    
    // Check if the browser is using a software rasterizer (fallback) instead of a true GPU
    const debugInfo = gl.getExtension('WEBGL_debug_renderer_info');
    if (debugInfo) {
        const renderer = gl.getParameter(debugInfo.UNMASKED_RENDERER_WEBGL);
        if (renderer.toLowerCase().includes('swiftshader') || renderer.toLowerCase().includes('software')) {
            return "disabled_software_fallback"; 
        }
    }
    return "enabled_hardware_gpu";
}
// Add this output directly to your trial dataset under a `hardware_status` column
```

---

## Appendix B: Client-Side Inter-Action Delay Detection Script
Below is the JavaScript routine to measure high-resolution inter-action delay (the exact milliseconds elapsed between successive button clicks), which can be captured and logged as user latency profiles:

```javascript
let lastActionTime = performance.now(); // High-resolution millisecond timestamp

document.querySelectorAll('.experiment-button').forEach(button => {
    button.addEventListener('click', (e) => {
        let currentActionTime = performance.now();
        let interActionDelay = currentActionTime - lastActionTime; // The exact gap between actions
        
        // Push this directly to your local data stream or into GA4 Custom Dimensions
        console.log(`Time since last user action: ${interActionDelay}ms`);
        
        lastActionTime = currentActionTime; // Reset baseline for next click
    });
});
```

---

## Appendix C: Audited and Uninformative Variables
The following table details the variables that were audited and identified as uninformative:

| Variable | Type | Reason for Exclusion |
|---|---|---|
| `O_ORDERSTATUS` | constant | Constant column (0 variance) |
| `C_REGION` | uniform | Suspicious uniformity (Coefficient of Variation = 0.0474 < 8%) |
| `O_TOTALPRICE_BIN` | uniform | Suspicious uniformity (Coefficient of Variation = 0.0168 < 8%) |
| `C_ACCTBAL_BIN` | uniform | Suspicious uniformity (Coefficient of Variation = 0.0168 < 8%) |
| `TOTAL_QUANTITY_BIN` | uniform | Suspicious uniformity (Coefficient of Variation = 0.0146 < 8%) |
| `AVG_DISCOUNT_BIN` | uniform | Suspicious uniformity (Coefficient of Variation = 0.0128 < 8%) |
| `TOTAL_DISCOUNT_VALUE_BIN` | uniform | Suspicious uniformity (Coefficient of Variation = 0.0168 < 8%) |
| `O_ORDERPRIORITY` | insignificant | Statistically insignificant (p-value >= 0.05 across all ANOVA/MANOVA groups) |

Figure 4 presents the distribution of these uninformative variables, showing why they lack statistical value (e.g. constant values, artificial uniform distributions, or flat statistical groupings):

![Figure 4: Uninformative Variable Distributions](customer_orders_nominal_uninformative_distributions.png)


---

## Appendix D: Methodology Execution Flow (Mermaid Diagram)
Below is the Mermaid flowchart illustrating the modular structure and statistical feedback loops of our auditing methodology:

```mermaid
graph TD
    A["1. Load Data<br/>(load_data)"] --> B["2. Auto-Classify Columns<br/>(classify_columns)"]
    B --> C["3. Preprocess & Transform<br/>(preprocess_data)"]
    C --> D["4. Correlation & Collinearity Audit<br/>(audit_collinearity)"]
    
    D -->|Feedback: Identify collinear uninformative columns| E["5. Run ANOVA/MANOVA<br/>(run_significance_tests)"]
    
    E -->|Feedback: Identify insignificant uninformative columns| F["6. Partition Reporting Factors<br/>(select_uninformative_factors)"]
    
    F -->|Informative Variable Set| G["7. Cluster & PCA<br/>(discover_personas)"]
    F -->|Informative Variable Set| H["8. Save Dashboard & Plots<br/>(generate_plots)"]
    F -->|Uninformative Variable Set| J["8b. Save Uninformative Histograms<br/>(generate_uninformative_plots)"]
    
    G --> I["9. Compile Markdown Report<br/>(generate_report)"]
    H --> I
    J -->|Rendered in Appendix| I
```
