# Module 3b: Correlation Analysis

## Introduction to Correlation Analysis

Correlation analysis is a statistical method used to evaluate the strength and direction of the relationship between two continuous variables. Unlike regression, which predicts one variable based on another, correlation simply measures how variables change together without implying causation.

### Key Concepts in Correlation Analysis

#### Correlation Coefficient

The correlation coefficient is a value between -1 and 1 that indicates:
- The strength of the relationship (how close the value is to -1 or 1)
- The direction of the relationship (positive or negative)

Common correlation coefficients include:
1. **Pearson's r**: Measures linear relationships between normally distributed variables
2. **Spearman's rho (ρ)**: Measures monotonic relationships between variables (doesn't require normality)
3. **Kendall's tau (τ)**: Another non-parametric measure, less sensitive to errors and discrepancies in data

#### Interpreting Correlation Coefficients

The absolute value of the correlation coefficient indicates the strength of the relationship:
- 0.00 - 0.19: Very weak correlation
- 0.20 - 0.39: Weak correlation
- 0.40 - 0.59: Moderate correlation
- 0.60 - 0.79: Strong correlation
- 0.80 - 1.00: Very strong correlation

The sign indicates the direction:
- Positive: As one variable increases, the other tends to increase
- Negative: As one variable increases, the other tends to decrease

#### Correlation vs. Causation

It's crucial to remember that correlation does not imply causation. Variables can be correlated because:
1. One variable causes the other
2. Both variables are caused by a third variable
3. The relationship is coincidental

## Pearson Correlation for Parametric Data

Pearson's correlation coefficient (r) measures the linear relationship between two continuous variables. It assumes that:
1. Both variables are normally distributed
2. The relationship between variables is linear
3. There are no significant outliers
4. Variables are measured on interval or ratio scales

### Interpretation

If the p-value from the correlation test is less than the significance level (e.g., 0.05), we reject the null hypothesis and conclude that there is a significant correlation between study hours and exam scores. The correlation coefficient (r) indicates the strength and direction of this relationship.

## Spearman and Kendall Correlations for Non-parametric Data

When the assumptions for Pearson correlation are not met (e.g., non-normal distribution, non-linear relationship), we can use non-parametric alternatives.

## Correlation Matrices

When dealing with multiple variables, it's useful to compute and visualize a correlation matrix.
