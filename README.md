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

## Required Packages for This Module

```r
# Install required packages (only need to do this once)
install.packages(c("ggplot2", "corrplot", "Hmisc", "psych", "vcd", "gmodels"))

# Load the packages
library(ggplot2)   # For data visualization
library(corrplot)  # For correlation matrices visualization
library(Hmisc)     # For correlation analysis
library(psych)     # For correlation analysis and visualization
library(vcd)       # For visualizing categorical data
library(gmodels)   # For cross-tabulation
```

## Pearson Correlation for Parametric Data

Pearson's correlation coefficient (r) measures the linear relationship between two continuous variables. It assumes that:
1. Both variables are normally distributed
2. The relationship between variables is linear
3. There are no significant outliers
4. Variables are measured on interval or ratio scales

### Example 1: Relationship Between Study Hours and Exam Scores

Let's examine the relationship between the number of hours students spend studying and their exam scores.

```r
# Create a data frame with study hours and exam scores
study_data <- data.frame(
  student = 1:30,
  study_hours = c(1.5, 2.3, 3.1, 4.8, 5.2, 6.0, 2.5, 3.7, 4.2, 5.5,
                 1.8, 2.7, 3.5, 4.5, 5.8, 1.2, 2.0, 3.3, 4.0, 5.0,
                 2.2, 3.0, 3.8, 4.3, 5.3, 1.0, 2.8, 3.4, 4.7, 5.7),
  exam_score = c(65, 72, 78, 85, 90, 92, 69, 79, 82, 88,
                67, 74, 77, 84, 91, 62, 70, 76, 81, 87,
                68, 75, 80, 83, 89, 60, 73, 78, 86, 90)
)

# View the first few rows of the data
head(study_data)
```

### Step 1: Check Assumptions

Before performing a Pearson correlation, we should check if the data meets the assumptions.

```r
# Check normality using Shapiro-Wilk test
shapiro.test(study_data$study_hours)
shapiro.test(study_data$exam_score)

# Create histograms to visualize distributions
par(mfrow = c(1, 2))
hist(study_data$study_hours, main = "Distribution of Study Hours", 
     xlab = "Study Hours", col = "lightblue")
hist(study_data$exam_score, main = "Distribution of Exam Scores", 
     xlab = "Exam Score", col = "lightgreen")
par(mfrow = c(1, 1))

# Create a scatter plot to check for linearity
plot(study_data$study_hours, study_data$exam_score, 
     main = "Study Hours vs. Exam Scores",
     xlab = "Study Hours", ylab = "Exam Score",
     pch = 19, col = "blue")
```

### Step 2: Calculate Pearson Correlation

```r
# Calculate Pearson correlation
pearson_result <- cor.test(study_data$study_hours, study_data$exam_score, 
                          method = "pearson")

# View the results
pearson_result
```

### Step 3: Visualize the Correlation

```r
# Create a scatter plot with regression line
ggplot(study_data, aes(x = study_hours, y = exam_score)) +
  geom_point(color = "blue", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = paste("Study Hours vs. Exam Scores (r =", 
                     round(pearson_result$estimate, 2), ")"),
       x = "Study Hours",
       y = "Exam Score") +
  theme_minimal()
```

### Interpretation

If the p-value from the correlation test is less than the significance level (e.g., 0.05), we reject the null hypothesis and conclude that there is a significant correlation between study hours and exam scores. The correlation coefficient (r) indicates the strength and direction of this relationship.

## Spearman and Kendall Correlations for Non-parametric Data

When the assumptions for Pearson correlation are not met (e.g., non-normal distribution, non-linear relationship), we can use non-parametric alternatives.

### Example 2: Relationship Between Anxiety Level and Test Performance

Let's examine the relationship between anxiety levels (measured on a scale of 1-10) and test performance.

```r
# Create a data frame with anxiety levels and test performance
anxiety_data <- data.frame(
  student = 1:25,
  anxiety_level = c(8, 6, 9, 4, 7, 3, 8, 5, 7, 2, 9, 6, 8, 3, 7, 5, 9, 4, 8, 2, 7, 5, 8, 3, 6),
  test_performance = c(65, 78, 62, 88, 72, 90, 68, 82, 75, 95, 60, 80, 70, 92, 73, 85, 63, 87, 69, 93, 74, 84, 67, 91, 76)
)

# View the first few rows of the data
head(anxiety_data)
```

### Step 1: Check Assumptions

```r
# Check normality using Shapiro-Wilk test
shapiro.test(anxiety_data$anxiety_level)
shapiro.test(anxiety_data$test_performance)

# Create a scatter plot to check for monotonic relationship
plot(anxiety_data$anxiety_level, anxiety_data$test_performance, 
     main = "Anxiety Level vs. Test Performance",
     xlab = "Anxiety Level (1-10)", ylab = "Test Performance",
     pch = 19, col = "purple")
```

### Step 2: Calculate Spearman Correlation

```r
# Calculate Spearman correlation
spearman_result <- cor.test(anxiety_data$anxiety_level, anxiety_data$test_performance, 
                           method = "spearman")

# View the results
spearman_result
```

### Step 3: Calculate Kendall Correlation

```r
# Calculate Kendall correlation
kendall_result <- cor.test(anxiety_data$anxiety_level, anxiety_data$test_performance, 
                          method = "kendall")

# View the results
kendall_result
```

### Step 4: Visualize the Correlation

```r
# Create a scatter plot with a smoothed line
ggplot(anxiety_data, aes(x = anxiety_level, y = test_performance)) +
  geom_point(color = "purple", size = 3, alpha = 0.7) +
  geom_smooth(method = "loess", se = TRUE, color = "darkred") +
  labs(title = paste("Anxiety Level vs. Test Performance (ρ =", 
                     round(spearman_result$estimate, 2), ")"),
       x = "Anxiety Level (1-10)",
       y = "Test Performance") +
  theme_minimal()
```

## Correlation Matrices

When dealing with multiple variables, it's useful to compute and visualize a correlation matrix.

### Example 3: Multiple Variables in Student Performance

Let's examine the relationships between multiple variables related to student performance.

```r
# Create a data frame with multiple variables
student_data <- data.frame(
  student = 1:30,
  study_hours = c(1.5, 2.3, 3.1, 4.8, 5.2, 6.0, 2.5, 3.7, 4.2, 5.5,
                 1.8, 2.7, 3.5, 4.5, 5.8, 1.2, 2.0, 3.3, 4.0, 5.0,
                 2.2, 3.0, 3.8, 4.3, 5.3, 1.0, 2.8, 3.4, 4.7, 5.7),
  sleep_hours = c(7.2, 6.5, 8.0, 5.5, 6.0, 7.5, 8.5, 6.8, 7.0, 5.8,
                 7.8, 6.2, 7.5, 6.0, 5.5, 8.2, 7.0, 6.5, 7.2, 6.8,
                 8.0, 7.5, 6.0, 6.5, 7.0, 8.5, 6.2, 7.8, 5.5, 6.5),
  attendance = c(85, 90, 75, 95, 80, 85, 70, 80, 90, 95,
                80, 85, 90, 75, 80, 70, 75, 85, 90, 80,
                75, 80, 85, 90, 75, 65, 80, 70, 85, 90),
  exam_score = c(65, 72, 78, 85, 90, 92, 69, 79, 82, 88,
                67, 74, 77, 84, 91, 62, 70, 76, 81, 87,
                68, 75, 80, 83, 89, 60, 73, 78, 86, 90)
)

# Remove the student ID column for correlation analysis
student_data_cor <- student_data[, -1]

# View the first few rows of the data
head(student_data)
```

### Step 1: Calculate the Correlation Matrix

```r
# Calculate the correlation matrix
cor_matrix <- cor(student_data_cor, method = "pearson")

# View the correlation matrix
print(cor_matrix)
```

### Step 2: Test the Significance of Correlations

```r
# Calculate correlation matrix with p-values using Hmisc package
cor_matrix_with_p <- rcorr(as.matrix(student_data_cor), type = "pearson")

# View the correlation coefficients
print(cor_matrix_with_p$r)

# View the p-values
print(cor_matrix_with_p$P)
```

### Step 3: Visualize the Correlation Matrix

```r
# Visualize the correlation matrix using corrplot
corrplot(cor_matrix, method = "circle", type = "upper", 
         tl.col = "black", tl.srt = 45,
         addCoef.col = "black", number.cex = 0.7,
         title = "Correlation Matrix of Student Performance Variables")

# Alternative visualization using the psych package
pairs.panels(student_data_cor, 
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,     # show density plots
             ellipses = TRUE)    # show correlation ellipses
