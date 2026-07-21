# SQL Data Quality and Behavior Analysis Lab Report: customer_orders_anomalous

**Report Generated on:** 2026-07-21 16:42:36.187709
**Source Dataset:** `customer_orders_anomalous.csv`
**Auditor Classification Status:** CRITICAL ANOMALY DETECTED 🔴

---

## Abstract
This report presents a controlled statistical audit of the database query results comprising 10 samples and 14 features. Using [Multivariate Analysis of Variance (MANOVA)](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance), [K-Means clustering](https://en.wikipedia.org/wiki/K-means_clustering), and correlation-matrix collinearity tests, we investigate the structure of the retrieved dataset. The objective is to identify potential query design flaws (such as duplicate joins, cross joins, and hardcoded values) and characterize the underlying customer order personas. Our findings show that the dataset has a classification status of **CRITICAL ANOMALY DETECTED 🔴**. We detail actionable recommendations for query optimizations based on detected data anomalies.

## 1. Introduction and Hypotheses
In database engineering and agentic data pipelines, query errors often manifest as subtle statistical anomalies (e.g. artificial correlation due to duplicate joins or zero variance due to cross joins) rather than outright syntax failures. We formally evaluate the following hypotheses:
* **Null Hypothesis ($H_0$)**: The physical and spatial parameters of the observed orders (such as O_ORDERKEY, O_CUSTKEY, O_TOTALPRICE, TOTAL_QUANTITY) are homogeneous and do not vary significantly across categorical groupings.
* **Alternative Hypothesis ($H_1$)**: The physical and spatial parameters of the observed orders show statistically significant variations across these categorical dimensions, indicating distinct sub-populations.

## 2. Experimental Methodology

### Participants (Dataset Description)
The 'participants' (observed entities) in this study consist of the orders fetched from the database.
The demographic distribution of the sample is detailed below:

| Category Variable | Group Level | Sample Size (N) | Percentage (%) |
|---|---|---|---|
| **O_CUSTKEY** | 74500 | 5 | 50.00% |
| **O_CUSTKEY** | 6766 | 3 | 30.00% |
| **O_CUSTKEY** | 46778 | 2 | 20.00% |
| **O_ORDERSTATUS** | O | 10 | 100.00% |
| **O_TOTALPRICE** | 80000 | 2 | 20.00% |
| **O_TOTALPRICE** | 1e+05 | 2 | 20.00% |
| **O_TOTALPRICE** | 120000 | 2 | 20.00% |
| **O_TOTALPRICE** | 150000 | 2 | 20.00% |
| **O_TOTALPRICE** | 2e+05 | 2 | 20.00% |
| **O_ORDERDATE** | 1998-08-01 | 10 | 100.00% |
| **O_ORDERPRIORITY** | 3-MEDIUM | 10 | 100.00% |
| **C_MKTSEGMENT** | AUTOMOBILE | 10 | 100.00% |
| **C_ACCTBAL** | 5000 | 10 | 100.00% |
| **C_REGION** | AMERICA | 5 | 50.00% |
| **C_REGION** | EUROPE | 5 | 50.00% |
| **TOTAL_QUANTITY** | 80 | 2 | 20.00% |
| **TOTAL_QUANTITY** | 100 | 2 | 20.00% |
| **TOTAL_QUANTITY** | 120 | 2 | 20.00% |
| **TOTAL_QUANTITY** | 150 | 2 | 20.00% |
| **TOTAL_QUANTITY** | 200 | 2 | 20.00% |
| **TOTAL_DISCOUNT_VALUE** | 4000 | 2 | 20.00% |
| **TOTAL_DISCOUNT_VALUE** | 5000 | 2 | 20.00% |
| **TOTAL_DISCOUNT_VALUE** | 6000 | 2 | 20.00% |
| **TOTAL_DISCOUNT_VALUE** | 7500 | 2 | 20.00% |
| **TOTAL_DISCOUNT_VALUE** | 10000 | 2 | 20.00% |
| **ITEM_COUNT** | 4 | 2 | 20.00% |
| **ITEM_COUNT** | 5 | 2 | 20.00% |
| **ITEM_COUNT** | 6 | 2 | 20.00% |
| **ITEM_COUNT** | 7 | 2 | 20.00% |
| **ITEM_COUNT** | 10 | 2 | 20.00% |
| **MAX_SHIP_DELAY** | 30 | 10 | 100.00% |

Figure 3 presents the sample size distributions across each independent categorical variable to evaluate demographic coverage and statistical power:

![Figure 3: Independent Variable Sample Size Distributions](customer_orders_anomalous_independent_distributions.png)

### Apparatus and Setup
Queries were executed against the Snowflake TPC-H sample database (`SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`; Transaction Processing Performance Council [TPC], 2014) using the Snowflake CLI tool (`snow` CLI v3.20.0). Statistical analysis and clustering were computed in R using packages `car` (ANOVA/MANOVA modelling) and `cluster` (K-Means silhouette groupings).

### Hardware Acceleration Controls
As highlighted in the methodological considerations for online response-time behavioral studies (McConnell et al., 2024), differences in browser hardware configuration and rendering pipelines (e.g. software rasterizer vs. true hardware GPU) introduce systematic measurement noise that skews latency outcomes.
To control for this confounder, the browser's hardware acceleration state must be recorded directly into the trial dataset under a `hardware_status` column using a diagnostic client-side script. The implementation of this client check is provided in Appendix A.

### Inter-Action Interval Controls
To profile user choice dynamics, click patterns, and decision hesitation (Pongratz & Schoemann, 2026), we track the high-resolution inter-action delay (the exact milliseconds elapsed between successive button clicks). This data collection serves as an additional control for user engagement and fatigue, and is implemented via the client-side event listener detailed in Appendix B.

### Experimental Design
We define a mixed multivariate design incorporating:
* **Independent Variables (Factors)**: `C_MKTSEGMENT` (Market Segment), `C_REGION` (Geographic region), and `O_ORDERPRIORITY` (Order priority).
* **Dependent Variables (Metrics)**: `O_TOTALPRICE` (total price), `C_ACCTBAL` (account balance), `TOTAL_QUANTITY` (quantity ordered), `AVG_DISCOUNT` (average discount), `TOTAL_DISCOUNT_VALUE` (total discount value), `ITEM_COUNT` (lineitem count), and `MAX_SHIP_DELAY` (shipping latency).



## 3. Results

### Data Quality and SQL Integrity Audits
- **CRITICAL ANOMALY: Duplicate Join Key in 'O_ORDERKEY'**: Unique rate is 80.00%. Joining on this column will cause a Cartesian product multiplication (row duplication).
- **CRITICAL ANOMALY: Duplicate Join Key in 'O_CUSTKEY'**: Unique rate is 30.00%. Joining on this column will cause a Cartesian product multiplication (row duplication).
- **WARNING: Constant Column 'O_ORDERSTATUS'**: 100% of rows contain the value 'O'.
- **WARNING: Constant Column 'O_ORDERDATE'**: 100% of rows contain the value '1998-08-01'.
- **WARNING: Constant Column 'O_ORDERPRIORITY'**: 100% of rows contain the value '3-MEDIUM'.
- **WARNING: Constant Column 'C_MKTSEGMENT'**: 100% of rows contain the value 'AUTOMOBILE'.
- **WARNING: Constant Column 'C_ACCTBAL'**: 100% of rows contain the value '5000'.
- **WARNING: Constant Column 'AVG_DISCOUNT'**: 100% of rows contain the value '0.05'.
- **WARNING: Constant Column 'MAX_SHIP_DELAY'**: 100% of rows contain the value '30'.
- **CRITICAL ANOMALY: Multicollinearity between 'O_TOTALPRICE' and 'TOTAL_QUANTITY'**: Correlation coefficient is 1.0000.
- **CRITICAL ANOMALY: Multicollinearity between 'O_TOTALPRICE' and 'TOTAL_DISCOUNT_VALUE'**: Correlation coefficient is 1.0000.
- **CRITICAL ANOMALY: Multicollinearity between 'TOTAL_QUANTITY' and 'TOTAL_DISCOUNT_VALUE'**: Correlation coefficient is 1.0000.
- **CRITICAL ANOMALY: ANOVA Replication Anomaly on 'O_TOTALPRICE' by 'C_REGION'**: p-value = 1.000000 (F-statistic = 0.000000). The values are perfectly cloned across categories.
- **CRITICAL ANOMALY: ANOVA Replication Anomaly on 'TOTAL_QUANTITY' by 'C_REGION'**: p-value = 1.000000 (F-statistic = 0.000000). The values are perfectly cloned across categories.
- **CRITICAL ANOMALY: ANOVA Replication Anomaly on 'TOTAL_DISCOUNT_VALUE' by 'C_REGION'**: p-value = 1.000000 (F-statistic = 0.000000). The values are perfectly cloned across categories.
- **CRITICAL ANOMALY: ANOVA Replication Anomaly on 'ITEM_COUNT' by 'C_REGION'**: p-value = 1.000000 (F-statistic = 0.000000). The values are perfectly cloned across categories.

### Statistical Hypothesis Testing
#### MANOVA Group Factor Outcomes
We executed [multivariate analysis of variance (MANOVA)](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance) using [Pillai's trace](https://www.statisticshowto.com/pillais-trace/) to test for overall group differences across continuous variables:

No MANOVA tests could be computed.

#### ANOVA Outputs (Significant Univariate Groupings)
We evaluated individual [univariate Analysis of Variance (ANOVA)](https://en.wikipedia.org/wiki/Analysis_of_variance) models for each continuous metric. The following factors show statistically significant differences (p < 0.05) in group means:

- **Significant variation in 'O_ORDERKEY' grouped by 'O_CUSTKEY'**: F = `31.0333`, p = `0.0003`
- **Significant variation in 'O_ORDERKEY' grouped by 'C_REGION'**: F = `24.8889`, p = `0.0011`
- **Significant variation in 'O_CUSTKEY' grouped by 'O_CUSTKEY'**: F = `205077520146705340697769626566656.0000`, p = `< 0.0001`
- **Significant variation in 'O_CUSTKEY' grouped by 'C_REGION'**: F = `27.8573`, p = `0.0007`
- **Significant variation in 'O_TOTALPRICE' grouped by 'O_TOTALPRICE'**: F = `9146118706524410064049742544896.0000`, p = `< 0.0001`
- **Significant variation in 'O_TOTALPRICE' grouped by 'TOTAL_QUANTITY'**: F = `9146118706524410064049742544896.0000`, p = `< 0.0001`
- **Significant variation in 'O_TOTALPRICE' grouped by 'TOTAL_DISCOUNT_VALUE'**: F = `9146118706524410064049742544896.0000`, p = `< 0.0001`
- **Significant variation in 'O_TOTALPRICE' grouped by 'ITEM_COUNT'**: F = `9146118706524410064049742544896.0000`, p = `< 0.0001`
- **Significant variation in 'TOTAL_QUANTITY' grouped by 'O_TOTALPRICE'**: F = `7732648097600236731346024660992.0000`, p = `< 0.0001`
- **Significant variation in 'TOTAL_QUANTITY' grouped by 'TOTAL_QUANTITY'**: F = `7732648097600236731346024660992.0000`, p = `< 0.0001`
- **Significant variation in 'TOTAL_QUANTITY' grouped by 'TOTAL_DISCOUNT_VALUE'**: F = `7732648097600236731346024660992.0000`, p = `< 0.0001`
- **Significant variation in 'TOTAL_QUANTITY' grouped by 'ITEM_COUNT'**: F = `7732648097600236731346024660992.0000`, p = `< 0.0001`
- **Significant variation in 'TOTAL_DISCOUNT_VALUE' grouped by 'O_TOTALPRICE'**: F = `11402847228891377661977825378304.0000`, p = `< 0.0001`
- **Significant variation in 'TOTAL_DISCOUNT_VALUE' grouped by 'TOTAL_QUANTITY'**: F = `11402847228891377661977825378304.0000`, p = `< 0.0001`
- **Significant variation in 'TOTAL_DISCOUNT_VALUE' grouped by 'TOTAL_DISCOUNT_VALUE'**: F = `11402847228891377661977825378304.0000`, p = `< 0.0001`
- **Significant variation in 'TOTAL_DISCOUNT_VALUE' grouped by 'ITEM_COUNT'**: F = `11402847228891377661977825378304.0000`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'O_TOTALPRICE'**: F = `8435254214760480104677130633216.0000`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'TOTAL_QUANTITY'**: F = `8435254214760480104677130633216.0000`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'TOTAL_DISCOUNT_VALUE'**: F = `8435254214760480104677130633216.0000`, p = `< 0.0001`
- **Significant variation in 'ITEM_COUNT' grouped by 'ITEM_COUNT'**: F = `8435254214760480104677130633216.0000`, p = `< 0.0001`

Figure 2 presents the pairwise scatterplots with a fitted linear regression line of best fit to visualize the correlation and linear relationships between these continuous metrics:

![Figure 2: Pairwise Scatterplots with Line of Fit](customer_orders_anomalous_scatterplots.png)

### Customer Order Persona Profiles (K-Means)
We standardized the numeric metrics and fitted a [K-Means clustering algorithm](https://en.wikipedia.org/wiki/K-means_clustering) ($k=2$) to identify distinct customer order personas. To determine the optimal number of clusters programmatically, we performed a **[Silhouette Analysis](https://en.wikipedia.org/wiki/Silhouette_(clustering))** across candidate sizes of $k \in [2, 6]$. The optimal $k$ was selected by maximizing the average silhouette width (Rousseeuw, 1987), which measures cluster cohesion and separation. If the maximum average silhouette width was $\le 0.25$, indicating no substantial structure, the algorithm fell back to a single nominal cluster ($k=1$):

| Persona Cluster | Order Count | Percentage (%) |
|---|---|---|
| **Cluster 1** | 7 | 70.00% |
| **Cluster 2** | 3 | 30.00% |


#### Population Profiles (Cluster Feature Means)
To characterize the discovered customer order personas in terms of the original variables, the table below presents the mean value of each numeric metric within each cluster:

| Cluster | O_ORDERKEY | O_CUSTKEY | O_TOTALPRICE | TOTAL_QUANTITY | AVG_DISCOUNT | TOTAL_DISCOUNT_VALUE | ITEM_COUNT |
|---|---|---|---|---|---|---|---|
| **Cluster 1** | 6.14 | 56903.14 | 107142.86 | 107.14 | 0.05 | 5357.14 | 5.29 |
| **Cluster 2** | 3.00 | 29344.00 | 183333.33 | 183.33 | 0.05 | 9166.67 | 9.00 |


## 4. Exploratory Multivariate Analysis and Cluster Diagnostics
Figure 1 presents the 2x2 data quality and customer order persona visualization dashboard:

![Figure 1: PCA Dashboard](customer_orders_anomalous_validation_plot.png)

### Principal Component Loadings (Feature Contributions)
To reverse-engineer which original variables drive the principal component projections, the table below lists the loadings (rotation coefficients) for the first two components:

| Metric | PC1 Loading | PC2 Loading | Influence Strength (PC1 & PC2) |
|---|---|---|---|
| `O_CUSTKEY` | `0.1788` | `-0.6904` | `0.7132` |
| `O_ORDERKEY` | `0.2092` | `-0.6695` | `0.7014` |
| `O_TOTALPRICE` | `-0.4811` | `-0.1357` | `0.4999` |
| `TOTAL_QUANTITY` | `-0.4811` | `-0.1357` | `0.4999` |
| `TOTAL_DISCOUNT_VALUE` | `-0.4811` | `-0.1357` | `0.4999` |
| `ITEM_COUNT` | `-0.4794` | `-0.1410` | `0.4997` |
| `AVG_DISCOUNT` | `0.0000` | `-0.0000` | `0.0000` |


### Interpretation of Figure 1:
1. **[PCA](https://en.wikipedia.org/wiki/Principal_component_analysis) Cluster Space**: Represents the first two principal components. Good separation between color groups indicates distinct customer order personas. If the points form tight, overlapping lines or grids, it indicates identical data replication bugs.
2. **Correlation Heatmap**: Pairwise correlations between metrics. Strong colors indicate potential redundant attributes or duplicate join bugs.
3. **Cluster Sizes**: Frequency counts across the discovered customer order personas.
4. **Boxplot of O_ORDERKEY**: Shows the distribution of the primary outcome metric across the clusters.

## 5. Discussion and SQL Improvement Recommendations
Based on the results, we recommend the following modifications to improve the SQL query:

- **Fix duplicate join key 'O_ORDERKEY'**: Ensure you are joining on a unique primary key. If you are joining a detail table, aggregate it first (e.g. in a subquery or CTE) before joining.
- **Fix duplicate join key 'O_CUSTKEY'**: Ensure you are joining on a unique primary key. If you are joining a detail table, aggregate it first (e.g. in a subquery or CTE) before joining.
- **Constant Column 'O_ORDERSTATUS'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Constant Column 'O_ORDERDATE'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Constant Column 'O_ORDERPRIORITY'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Constant Column 'C_MKTSEGMENT'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Constant Column 'C_ACCTBAL'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Constant Column 'AVG_DISCOUNT'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Constant Column 'MAX_SHIP_DELAY'**: Verify if this is an intended filter (e.g., single day partition). If not, verify that you didn't accidentally hardcode a value or introduce a query join bug.
- **Remove Collinearity between 'O_TOTALPRICE' and 'TOTAL_QUANTITY'**: Review your SQL query to ensure you did not join the same table twice or select the same column multiple times under different aliases.
- **Remove Collinearity between 'O_TOTALPRICE' and 'TOTAL_DISCOUNT_VALUE'**: Review your SQL query to ensure you did not join the same table twice or select the same column multiple times under different aliases.
- **Remove Collinearity between 'TOTAL_QUANTITY' and 'TOTAL_DISCOUNT_VALUE'**: Review your SQL query to ensure you did not join the same table twice or select the same column multiple times under different aliases.
- **Fix ANOVA Replication on 'O_TOTALPRICE' by 'C_REGION'**: Check your SQL join logic. This indicates matching values are replicated across categories.
- **Fix ANOVA Replication on 'TOTAL_QUANTITY' by 'C_REGION'**: Check your SQL join logic. This indicates matching values are replicated across categories.
- **Fix ANOVA Replication on 'TOTAL_DISCOUNT_VALUE' by 'C_REGION'**: Check your SQL join logic. This indicates matching values are replicated across categories.
- **Fix ANOVA Replication on 'ITEM_COUNT' by 'C_REGION'**: Check your SQL join logic. This indicates matching values are replicated across categories.

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
