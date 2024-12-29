# False-Discovery Rates with the Hedenfalk et al. (2001) Microarray Data

## Project Overview

This project aims to provide hands-on experience in genome-wide analysis of differentially expressed genes (DEGs) using permutation distributions and the False Discovery Rate (FDR). By reproducing key results from Storey and Tibshirani (2003), we explore the effectiveness of different statistical methods for DEG detection and compare them to standard parametric methods.

The analysis uses the microarray data originally described in Hedenfalk et al. (2001). These data were preprocessed following Storey and Tibshirani's specifications, including log-transformation, standardization, and filtering based on expression thresholds.

## Key Objectives

1. Reproduce Results from Storey and Tibshirani (2003): Using the `qvalue` package, we compare results from parametric $t$-tests, Wilcoxon tests, and permutation-based methods for DEG detection.
2. Analyze Statistical Approaches: Evaluate the number of DEGs identified under different statistical assumptions and assess the impact of incorporating an estimated null-gene proportion.
3. Explore False Discovery Rates: Use the `FDRestimation` package to compute and interpret FDRs for parametric, Wilcoxon, and permutation-based $p$-values.

## Requirements

### R Packages
The following R packages are required for this analysis:

- `knitr`: For generating reproducible documents.
- `FDRestimation`: For computing FDR statistics.
- `lemon`: For additional data visualization tools.
- `BiocManager`: For managing Bioconductor packages.
- `qvalue`: For analyzing permutation-based $p$-values.

Install the `qvalue` package as follows:

```
if (!require("qvalue", quietly = TRUE))
    BiocManager::install("qvalue")
```

## Key Components

### Data Preparation

- Dataset: The microarray data analyzed were preprocessed as described in Storey and Tibshirani (2003):

Genes with expression ratios $\ge$ 20 in any group were removed.
Data were log-transformed and standardized (centered and scaled).

### Statistical Tests
- Parametric $t$-Tests: Welch's $t$-test was performed for group comparisons.
- Permutation $t$-Tests: Precomputed permutation $t$-statistics from the `qvalue` package were used for computational efficiency.
- Wilcoxon Tests: Sum-of-ranks statistics (Wilcoxon) were computed to compare the BRCA1 and BRCA2 groups.
  
### False Discovery Rates

- FDRs were computed using the `FDRestimation` package for parametric, permutation, and Wilcoxon $p$-values. The impact of incorporating an estimated null-gene proportion (67% as per Storey and Tibshirani) was also analyzed.

### Results and Comparisons

- The number of DEGs identified at FDR thresholds of 5% and 2% was compared across methods.
- Results were contextualized with Storey and Tibshirani's findings, exploring possible reasons for differences.

## Outputs

- FDR Statistics Plots: Visualizations for parametric, permutation, and Wilcoxon $p$-value FDRs.
- Tables of Significant Genes: Genes with FDR $\le$ 5% or 2% for each method.
- Conclusions: A summary of the findings, highlighting the strengths and limitations of different statistical approaches.

## How to Use

1. Clone or download the project files, including the .Rmd file and the Hedenfalk dataset.
2. Open the .Rmd file in RStudio.
3. Knit the document to HTML, PDF, or Word format to generate the analysis report.
4. Review the results, including the plots and tables, for insights into DEG detection.

## Conclusions

This project demonstrates the impact of statistical methodology on the identification of DEGs in microarray data. By implementing and comparing parametric, permutation-based, and rank-based methods, we gain valuable insights into the trade-offs between power and assumptions in DEG analysis.
