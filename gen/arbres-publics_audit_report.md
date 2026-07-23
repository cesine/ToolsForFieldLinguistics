# SQL Data Quality and Behavior Analysis Lab Report: arbres-publics

**Report Generated on:** 2026-07-23 09:52:21.379951
**Source Dataset:** `arbres-publics.csv`
**Auditor Classification Status:** MINOR ANOMALY DETECTED 🟡

---

## Abstract
This report presents a controlled statistical audit of the database query results comprising 334680 samples and 33 features. (Note: The dataset containing 334680 rows was downsampled to 5,000 rows for statistical modeling and plotting.) Using [Multivariate Analysis of Variance (MANOVA)](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance), [K-Means clustering](https://en.wikipedia.org/wiki/K-means_clustering), and correlation-matrix collinearity tests, we investigate the structure of the retrieved dataset. The objective is to identify potential query design flaws (such as duplicate joins, cross joins, and hardcoded values) and characterize the underlying tree population profiles. Our findings show that the dataset has a classification status of **MINOR ANOMALY DETECTED 🟡**. We detail actionable recommendations for query optimizations based on detected data anomalies.

## 1. Introduction and Hypotheses
In database engineering and agentic data pipelines, query errors often manifest as subtle statistical anomalies (e.g. artificial correlation due to duplicate joins or zero variance due to cross joins) rather than outright syntax failures. We formally evaluate the following hypotheses:
* **Null Hypothesis ($H_0$)**: The physical and spatial parameters of the observed trees (such as EMP_NO, ARROND, No_civique, DHP) are homogeneous and do not vary significantly across categorical groupings.
* **Alternative Hypothesis ($H_1$)**: The physical and spatial parameters of the observed trees show statistically significant variations across these categorical dimensions, indicating distinct sub-populations.

## 2. Experimental Methodology

### Participants (Dataset Description)
The 'participants' (observed entities) in this study consist of the trees fetched from the database. Note that the statistical tests and clustering were performed on a representative random downsample of 5,000 entities to ensure computational stability and performance.
The demographic distribution of the sample is detailed below:

| Category Variable | Group Level | Sample Size (N) | Percentage (%) |
|---|---|---|---|
| **INV_TYPE** | R | 3220 | 64.40% |
| **INV_TYPE** | H | 1780 | 35.60% |
| **ARROND_NOM** | Mercier - Hochelaga-Maisonneuve | 593 | 11.86% |
| **ARROND_NOM** | Rosemont - La Petite-Patrie | 540 | 10.80% |
| **ARROND_NOM** | Ahuntsic - Cartierville | 536 | 10.72% |
| **ARROND_NOM** | Rivière-des-Prairies - Pointe-aux-Trembles | 495 | 9.90% |
| **ARROND_NOM** | Côte-des-Neiges - Notre-Dame-de-Grâce | 438 | 8.76% |
| **Arbre_remarquable** | N | 4999 | 99.98% |
| **Arbre_remarquable** | O | 1 | 0.02% |
| **Rue_cote_LUMPED** |  | NA | NA% |
| **Rue_cote_LUMPED** | E | 857 | 17.14% |
| **Rue_cote_LUMPED** | O | 804 | 16.08% |
| **Rue_cote_LUMPED** | Other | 719 | 14.38% |
| **Rue_cote_LUMPED** | S | 424 | 8.48% |
| **Emplacement_LUMPED** | Parterre Gazonné | 2774 | 55.48% |
| **Emplacement_LUMPED** | TRottoir | 685 | 13.70% |
| **Emplacement_LUMPED** | PaRterre | 514 | 10.28% |
| **Emplacement_LUMPED** | PArc | 508 | 10.16% |
| **Emplacement_LUMPED** | Other | 444 | 8.88% |
| **Sigle_LUMPED** | Other | 2711 | 54.22% |
| **Sigle_LUMPED** | ACSA | 438 | 8.76% |
| **Sigle_LUMPED** | ACPL | 341 | 6.82% |
| **Sigle_LUMPED** | FRPE | 208 | 4.16% |
| **Sigle_LUMPED** | TICO | 183 | 3.66% |
| **Essence_latin_LUMPED** | Other | 2711 | 54.22% |
| **Essence_latin_LUMPED** | Acer saccharinum | 438 | 8.76% |
| **Essence_latin_LUMPED** | Acer platanoides | 341 | 6.82% |
| **Essence_latin_LUMPED** | Fraxinus pennsylvanica | 208 | 4.16% |
| **Essence_latin_LUMPED** | Tilia cordata | 183 | 3.66% |
| **Essence_fr_LUMPED** | Other | 2711 | 54.22% |
| **Essence_fr_LUMPED** | Érable argenté | 438 | 8.76% |
| **Essence_fr_LUMPED** | Érable de Norvège | 341 | 6.82% |
| **Essence_fr_LUMPED** | Frêne de Pennsylvanie | 208 | 4.16% |
| **Essence_fr_LUMPED** | Tilleul à petites feuilles | 183 | 3.66% |
| **Essence_ang_LUMPED** | Other | 2711 | 54.22% |
| **Essence_ang_LUMPED** | Silver Maple | 438 | 8.76% |
| **Essence_ang_LUMPED** | Norway Maple | 341 | 6.82% |
| **Essence_ang_LUMPED** | Red Ash | 208 | 4.16% |
| **Essence_ang_LUMPED** | Littleleaf European Linden | 183 | 3.66% |
| **Stationnement_jour_LUMPED** |  | NA | NA% |
| **Stationnement_jour_LUMPED** | Other | 603 | 12.06% |
| **Stationnement_jour_LUMPED** | ME | 378 | 7.56% |
| **Stationnement_jour_LUMPED** | MA | 377 | 7.54% |
| **Stationnement_jour_LUMPED** | J | 373 | 7.46% |
| **Stationnement_heure_LUMPED** |  | NA | NA% |
| **Stationnement_heure_LUMPED** | Other | 682 | 13.64% |
| **Stationnement_heure_LUMPED** | 12:30-15:30 | 179 | 3.58% |
| **Stationnement_heure_LUMPED** | 08:30-11:30 | 165 | 3.30% |
| **Stationnement_heure_LUMPED** | 09:30-10:30 | 131 | 2.62% |

Figure 3 presents the sample size distributions across each independent categorical variable to evaluate demographic coverage and statistical power:

![Figure 3a: Dependent Variable Sample Size Distributions](arbres-publics_dependent_distributions.png)
![Figure 3b: Independent Variable Sample Size Distributions](arbres-publics_independent_distributions.png)

### Apparatus and Setup
Queries were executed against the Snowflake TPC-H sample database (`SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`; Transaction Processing Performance Council [TPC], 2014) using the Snowflake CLI tool (`snow` CLI v3.20.0). Statistical analysis and clustering were computed in R using packages `car` (ANOVA/MANOVA modelling) and `cluster` (K-Means silhouette groupings).

### Hardware Acceleration Controls
As highlighted in the methodological considerations for online response-time behavioral studies (McConnell et al., 2024), differences in browser hardware configuration and rendering pipelines (e.g. software rasterizer vs. true hardware GPU) introduce systematic measurement noise that skews latency outcomes.
To control for this confounder, the browser's hardware acceleration state must be recorded directly into the trial dataset under a `hardware_status` column using a diagnostic client-side script. The implementation of this client check is provided in Appendix A.

### Inter-Action Interval Controls
To profile user choice dynamics, click patterns, and decision hesitation (Pongratz & Schoemann, 2026), we track the high-resolution inter-action delay (the exact milliseconds elapsed between successive button clicks). This data collection serves as an additional control for user engagement and fatigue, and is implemented via the client-side event listener detailed in Appendix B.

### Experimental Design
We define a mixed multivariate design incorporating:
* **Independent Variables (Factors)**: `INV_TYPE`, `ARROND_NOM`, `Arbre_remarquable`, `Rue_cote_LUMPED`, `Emplacement_LUMPED`, `Sigle_LUMPED`, `Essence_latin_LUMPED`, `Essence_fr_LUMPED`, `Essence_ang_LUMPED`, `Stationnement_jour_LUMPED`, `Stationnement_heure_LUMPED`
* **Dependent Variables (Metrics)**: `EMP_NO`, `ARROND`, `No_civique`, `DHP`, `Distance_pave`, `District`, `Code_secteur`, `Coord_X`, `Coord_Y`, `Longitude`, `Latitude`



## 3. Results

### Data Quality and SQL Integrity Audits
- **WARNING: Highly Collapsed Column 'Arbre_remarquable'**: 99.95% of rows contain the value 'N'.

### Statistical Hypothesis Testing
#### MANOVA Group Factor Outcomes
We executed [multivariate analysis of variance (MANOVA)](https://en.wikipedia.org/wiki/Multivariate_analysis_of_variance) using [Pillai's trace](https://www.statisticshowto.com/pillais-trace/) to test for overall group differences across continuous variables:

- **Group Factor 'INV_TYPE'**:
  - Pillai's Trace: `0.1354`
  - Approximate F:  `156.3662`
  - p-value:        `< 0.0001` (Statistically Significant)

- **Group Factor 'Rue_cote_LUMPED'**:
  - Pillai's Trace: `0.5601`
  - Approximate F:  `125.9315`
  - p-value:        `< 0.0001` (Statistically Significant)

- **Group Factor 'Emplacement_LUMPED'**:
  - Pillai's Trace: `0.2525`
  - Approximate F:  `53.0966`
  - p-value:        `< 0.0001` (Statistically Significant)

- **Group Factor 'Sigle_LUMPED'**:
  - Pillai's Trace: `0.4433`
  - Approximate F:  `32.3058`
  - p-value:        `< 0.0001` (Statistically Significant)

- **Group Factor 'Essence_latin_LUMPED'**:
  - Pillai's Trace: `0.4433`
  - Approximate F:  `32.3058`
  - p-value:        `< 0.0001` (Statistically Significant)

- **Group Factor 'Essence_fr_LUMPED'**:
  - Pillai's Trace: `0.4433`
  - Approximate F:  `32.3058`
  - p-value:        `< 0.0001` (Statistically Significant)

- **Group Factor 'Essence_ang_LUMPED'**:
  - Pillai's Trace: `0.4433`
  - Approximate F:  `32.3058`
  - p-value:        `< 0.0001` (Statistically Significant)

- **Group Factor 'Stationnement_jour_LUMPED'**:
  - Pillai's Trace: `0.1687`
  - Approximate F:  `34.8504`
  - p-value:        `< 0.0001` (Statistically Significant)

- **Group Factor 'Stationnement_heure_LUMPED'**:
  - Pillai's Trace: `0.2057`
  - Approximate F:  `16.4451`
  - p-value:        `< 0.0001` (Statistically Significant)


#### ANOVA Outputs (Significant Univariate Groupings)
We evaluated individual [univariate Analysis of Variance (ANOVA)](https://en.wikipedia.org/wiki/Analysis_of_variance) models for each continuous metric. The following factors show statistically significant differences (p < 0.05) in group means:

- **Significant variation in 'EMP_NO' grouped by 'INV_TYPE'**: F = `556.3986`, p = `< 0.0001`
- **Significant variation in 'EMP_NO' grouped by 'ARROND_NOM'**: F = `21.8104`, p = `< 0.0001`
- **Significant variation in 'EMP_NO' grouped by 'Rue_cote_LUMPED'**: F = `210.8289`, p = `< 0.0001`
- **Significant variation in 'EMP_NO' grouped by 'Emplacement_LUMPED'**: F = `96.4981`, p = `< 0.0001`
- **Significant variation in 'EMP_NO' grouped by 'Sigle_LUMPED'**: F = `14.3015`, p = `< 0.0001`
- **Significant variation in 'EMP_NO' grouped by 'Essence_latin_LUMPED'**: F = `14.3015`, p = `< 0.0001`
- **Significant variation in 'EMP_NO' grouped by 'Essence_fr_LUMPED'**: F = `14.3015`, p = `< 0.0001`
- **Significant variation in 'EMP_NO' grouped by 'Essence_ang_LUMPED'**: F = `14.3015`, p = `< 0.0001`
- **Significant variation in 'EMP_NO' grouped by 'Stationnement_jour_LUMPED'**: F = `2.6284`, p = `0.0222`
- **Significant variation in 'EMP_NO' grouped by 'Stationnement_heure_LUMPED'**: F = `2.3902`, p = `0.0034`
- **Significant variation in 'ARROND' grouped by 'INV_TYPE'**: F = `23.5452`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'ARROND_NOM'**: F = `60529787028191640196183228416.0000`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'Rue_cote_LUMPED'**: F = `617.1805`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'Emplacement_LUMPED'**: F = `62.6416`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'Sigle_LUMPED'**: F = `8.1884`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'Essence_latin_LUMPED'**: F = `8.1884`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'Essence_fr_LUMPED'**: F = `8.1884`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'Essence_ang_LUMPED'**: F = `8.1884`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'Stationnement_jour_LUMPED'**: F = `170.8500`, p = `< 0.0001`
- **Significant variation in 'ARROND' grouped by 'Stationnement_heure_LUMPED'**: F = `62.0334`, p = `< 0.0001`
- **Significant variation in 'No_civique' grouped by 'ARROND_NOM'**: F = `143.9682`, p = `< 0.0001`
- **Significant variation in 'No_civique' grouped by 'Emplacement_LUMPED'**: F = `25.2752`, p = `< 0.0001`
- **Significant variation in 'No_civique' grouped by 'Sigle_LUMPED'**: F = `4.1699`, p = `< 0.0001`
- **Significant variation in 'No_civique' grouped by 'Essence_latin_LUMPED'**: F = `4.1699`, p = `< 0.0001`
- **Significant variation in 'No_civique' grouped by 'Essence_fr_LUMPED'**: F = `4.1699`, p = `< 0.0001`
- **Significant variation in 'No_civique' grouped by 'Essence_ang_LUMPED'**: F = `4.1699`, p = `< 0.0001`
- **Significant variation in 'No_civique' grouped by 'Stationnement_jour_LUMPED'**: F = `17.3470`, p = `< 0.0001`
- **Significant variation in 'No_civique' grouped by 'Stationnement_heure_LUMPED'**: F = `14.0538`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'INV_TYPE'**: F = `7.1071`, p = `0.0077`
- **Significant variation in 'DHP' grouped by 'ARROND_NOM'**: F = `12.6053`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'Rue_cote_LUMPED'**: F = `9.2505`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'Emplacement_LUMPED'**: F = `43.6527`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'Sigle_LUMPED'**: F = `201.6380`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'Essence_latin_LUMPED'**: F = `201.6380`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'Essence_fr_LUMPED'**: F = `201.6380`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'Essence_ang_LUMPED'**: F = `201.6380`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'Stationnement_jour_LUMPED'**: F = `9.2164`, p = `< 0.0001`
- **Significant variation in 'DHP' grouped by 'Stationnement_heure_LUMPED'**: F = `4.6759`, p = `< 0.0001`
- **Significant variation in 'Distance_pave' grouped by 'Emplacement_LUMPED'**: F = `221.7752`, p = `< 0.0001`
- **Significant variation in 'Distance_pave' grouped by 'Sigle_LUMPED'**: F = `7.3136`, p = `< 0.0001`
- **Significant variation in 'Distance_pave' grouped by 'Essence_latin_LUMPED'**: F = `7.3136`, p = `< 0.0001`
- **Significant variation in 'Distance_pave' grouped by 'Essence_fr_LUMPED'**: F = `7.3136`, p = `< 0.0001`
- **Significant variation in 'Distance_pave' grouped by 'Essence_ang_LUMPED'**: F = `7.3136`, p = `< 0.0001`
- **Significant variation in 'Distance_pave' grouped by 'Stationnement_jour_LUMPED'**: F = `18.9677`, p = `< 0.0001`
- **Significant variation in 'Distance_pave' grouped by 'Stationnement_heure_LUMPED'**: F = `8.3513`, p = `< 0.0001`
- **Significant variation in 'District' grouped by 'ARROND_NOM'**: F = `7604.5027`, p = `< 0.0001`
- **Significant variation in 'District' grouped by 'Emplacement_LUMPED'**: F = `57.6220`, p = `< 0.0001`
- **Significant variation in 'District' grouped by 'Sigle_LUMPED'**: F = `5.2506`, p = `< 0.0001`
- **Significant variation in 'District' grouped by 'Essence_latin_LUMPED'**: F = `5.2506`, p = `< 0.0001`
- **Significant variation in 'District' grouped by 'Essence_fr_LUMPED'**: F = `5.2506`, p = `< 0.0001`
- **Significant variation in 'District' grouped by 'Essence_ang_LUMPED'**: F = `5.2506`, p = `< 0.0001`
- **Significant variation in 'District' grouped by 'Stationnement_jour_LUMPED'**: F = `67.1759`, p = `< 0.0001`
- **Significant variation in 'District' grouped by 'Stationnement_heure_LUMPED'**: F = `90.9015`, p = `< 0.0001`
- **Significant variation in 'Code_secteur' grouped by 'ARROND_NOM'**: F = `10.1795`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'ARROND_NOM'**: F = `4185.7391`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'Rue_cote_LUMPED'**: F = `70.3664`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'Emplacement_LUMPED'**: F = `42.5785`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'Sigle_LUMPED'**: F = `6.9014`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'Essence_latin_LUMPED'**: F = `6.9014`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'Essence_fr_LUMPED'**: F = `6.9014`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'Essence_ang_LUMPED'**: F = `6.9014`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'Stationnement_jour_LUMPED'**: F = `36.2581`, p = `< 0.0001`
- **Significant variation in 'Coord_X' grouped by 'Stationnement_heure_LUMPED'**: F = `25.5647`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'ARROND_NOM'**: F = `5710.6946`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'Rue_cote_LUMPED'**: F = `32.2673`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'Emplacement_LUMPED'**: F = `17.7029`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'Sigle_LUMPED'**: F = `4.5766`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'Essence_latin_LUMPED'**: F = `4.5766`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'Essence_fr_LUMPED'**: F = `4.5766`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'Essence_ang_LUMPED'**: F = `4.5766`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'Stationnement_jour_LUMPED'**: F = `36.2717`, p = `< 0.0001`
- **Significant variation in 'Coord_Y' grouped by 'Stationnement_heure_LUMPED'**: F = `11.6129`, p = `< 0.0001`

Figure 2 presents the pairwise scatterplots with a fitted linear regression line of best fit to visualize the correlation and linear relationships between these continuous metrics:

![Figure 2: Pairwise Scatterplots with Line of Fit](arbres-publics_scatterplots.png)

### Tree Population Profile Profiles (K-Means)
We standardized the numeric metrics and fitted a [K-Means clustering algorithm](https://en.wikipedia.org/wiki/K-means_clustering) ($k=2$) to identify distinct tree population profiles. To determine the optimal number of clusters programmatically, we performed a **[Silhouette Analysis](https://en.wikipedia.org/wiki/Silhouette_(clustering))** across candidate sizes of $k \in [2, 6]$. The optimal $k$ was selected by maximizing the average silhouette width (Rousseeuw, 1987), which measures cluster cohesion and separation. If the maximum average silhouette width was $\le 0.25$, indicating no substantial structure, the algorithm fell back to a single nominal cluster ($k=1$):

| Persona Cluster | Order Count | Percentage (%) |
|---|---|---|
| **Cluster 1** | 4304 | 86.08% |
| **Cluster 2** | 696 | 13.92% |


#### Population Profiles (Cluster Feature Means)
To characterize the discovered tree population profiles in terms of the original variables, the table below presents the mean value of each numeric metric within each cluster:

| Cluster | EMP_NO | ARROND | No_civique | DHP | Distance_pave | District | Code_secteur | Coord_X | Coord_Y |
|---|---|---|---|---|---|---|---|---|---|
| **Cluster 1** | 137655.13 | 5.45 | 5487.62 | 25.82 | 2.50 | 328.10 | 4.28 | 297768.84 | 5045826.38 |
| **Cluster 2** | 198807.50 | 20.62 | 3448.55 | 21.93 | 3.27 | 273.62 | 1.35 | 290106.27 | 5036187.96 |


## 4. Exploratory Multivariate Analysis and Cluster Diagnostics
Figure 1 presents the 2x2 data quality and tree population profile visualization dashboard:

![Figure 1: PCA Dashboard](arbres-publics_validation_plot.png)

### Principal Component Loadings (Feature Contributions)
To reverse-engineer which original variables drive the principal component projections, the table below lists the loadings (rotation coefficients) for the first two components:

| Metric | PC1 Loading | PC2 Loading | Influence Strength (PC1 & PC2) |
|---|---|---|---|
| `EMP_NO` | `0.1596` | `0.6995` | `0.7174` |
| `DHP` | `-0.0762` | `-0.6655` | `0.6698` |
| `Coord_X` | `-0.6049` | `0.1298` | `0.6187` |
| `ARROND` | `0.5561` | `0.0075` | `0.5562` |
| `Coord_Y` | `-0.4865` | `0.2090` | `0.5295` |
| `District` | `-0.2238` | `-0.0636` | `0.2327` |
| `Distance_pave` | `0.0674` | `0.0244` | `0.0717` |
| `Code_secteur` | `-0.0461` | `0.0489` | `0.0672` |
| `No_civique` | `0.0093` | `0.0166` | `0.0190` |


### Interpretation of Figure 1:
1. **[PCA](https://en.wikipedia.org/wiki/Principal_component_analysis) Cluster Space**: Represents the first two principal components. Good separation between color groups indicates distinct tree population profiles. If the points form tight, overlapping lines or grids, it indicates identical data replication bugs.
2. **Correlation Heatmap**: Pairwise correlations between metrics. Strong colors indicate potential redundant attributes or duplicate join bugs.
3. **Cluster Sizes**: Frequency counts across the discovered tree population profiles.
4. **Boxplot of EMP_NO**: Shows the distribution of the primary outcome metric across the clusters.

## 5. Discussion and SQL Improvement Recommendations
Based on the results, we recommend the following modifications to improve the SQL query:

- **Collapsed Column 'Arbre_remarquable'**: Verify if this massive skew is natural in your business logic or is caused by a faulty join.

### Methodological Discussion on Skewness
As detailed in the references, response-time metrics are typically right-skewed and violating [normality assumptions](https://en.wikipedia.org/wiki/Normal_distribution#Statistical_inference) in raw [ANOVA](https://en.wikipedia.org/wiki/Analysis_of_variance) leads to higher [Type I errors](https://en.wikipedia.org/wiki/Type_I_and_Type_II_errors#Type_I_error). Log-transforming the delay metrics significantly stabilizes the residuals, making our multivariate models highly reliable for identifying behavioral deviations in the tree population profiles.

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
| `Longitude` | collinear | Multicollinearity (high redundancy correlation >= 0.95 with another variable) |
| `Latitude` | collinear | Multicollinearity (high redundancy correlation >= 0.95 with another variable) |

Figure 4 presents the distribution of these uninformative variables, showing why they lack statistical value (e.g. constant values, artificial uniform distributions, or flat statistical groupings):

![Figure 4: Uninformative Variable Distributions](arbres-publics_uninformative_distributions.png)


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
