# Module 3: Correlation Analysis and Chi-square Tests
# This script demonstrates correlation analysis and chi-square tests

# ===== Load Required Packages =====
# Install required packages if not already installed
required_packages <- c("ggplot2", "corrplot", "Hmisc", "psych", "vcd", "gmodels")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# Load the packages
library(ggplot2)   # For data visualization
library(corrplot)  # For correlation matrices visualization
library(Hmisc)     # For correlation analysis
library(psych)     # For correlation analysis and visualization
library(vcd)       # For visualizing categorical data
library(gmodels)   # For cross-tabulation

# ===== Example 1: Pearson Correlation (Study Hours and Exam Scores) =====
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

# Step 1: Check Assumptions
# Check normality using Shapiro-Wilk test
shapiro_hours <- shapiro.test(study_data$study_hours)
shapiro_score <- shapiro.test(study_data$exam_score)
print(shapiro_hours)
print(shapiro_score)

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

# Step 2: Calculate Pearson Correlation
pearson_result <- cor.test(study_data$study_hours, study_data$exam_score, 
                          method = "pearson")
print(pearson_result)

# Step 3: Visualize the Correlation
# Create a scatter plot with regression line
pearson_plot <- ggplot(study_data, aes(x = study_hours, y = exam_score)) +
  geom_point(color = "blue", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = paste("Study Hours vs. Exam Scores (r =", 
                     round(pearson_result$estimate, 2), ")"),
       x = "Study Hours",
       y = "Exam Score") +
  theme_minimal()
print(pearson_plot)

# ===== Example 2: Spearman and Kendall Correlations (Anxiety and Test Performance) =====
# Create a data frame with anxiety levels and test performance
anxiety_data <- data.frame(
  student = 1:25,
  anxiety_level = c(8, 6, 9, 4, 7, 3, 8, 5, 7, 2, 9, 6, 8, 3, 7, 5, 9, 4, 8, 2, 7, 5, 8, 3, 6),
  test_performance = c(65, 78, 62, 88, 72, 90, 68, 82, 75, 95, 60, 80, 70, 92, 73, 85, 63, 87, 69, 93, 74, 84, 67, 91, 76)
)

# View the first few rows of the data
head(anxiety_data)

# Step 1: Check Assumptions
# Check normality using Shapiro-Wilk test
shapiro_anxiety <- shapiro.test(anxiety_data$anxiety_level)
shapiro_performance <- shapiro.test(anxiety_data$test_performance)
print(shapiro_anxiety)
print(shapiro_performance)

# Create a scatter plot to check for monotonic relationship
plot(anxiety_data$anxiety_level, anxiety_data$test_performance, 
     main = "Anxiety Level vs. Test Performance",
     xlab = "Anxiety Level (1-10)", ylab = "Test Performance",
     pch = 19, col = "purple")

# Step 2: Calculate Spearman Correlation
spearman_result <- cor.test(anxiety_data$anxiety_level, anxiety_data$test_performance, 
                           method = "spearman")
print(spearman_result)

# Step 3: Calculate Kendall Correlation
kendall_result <- cor.test(anxiety_data$anxiety_level, anxiety_data$test_performance, 
                          method = "kendall")
print(kendall_result)

# Step 4: Visualize the Correlation
# Create a scatter plot with a smoothed line
spearman_plot <- ggplot(anxiety_data, aes(x = anxiety_level, y = test_performance)) +
  geom_point(color = "purple", size = 3, alpha = 0.7) +
  geom_smooth(method = "loess", se = TRUE, color = "darkred") +
  labs(title = paste("Anxiety Level vs. Test Performance (ρ =", 
                     round(spearman_result$estimate, 2), ")"),
       x = "Anxiety Level (1-10)",
       y = "Test Performance") +
  theme_minimal()
print(spearman_plot)

# ===== Example 3: Correlation Matrix (Student Performance) =====
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

# Step 1: Calculate the Correlation Matrix
# Calculate the correlation matrix
cor_matrix <- cor(student_data_cor, method = "pearson")
print(cor_matrix)

# Step 2: Test the Significance of Correlations
# Calculate correlation matrix with p-values using Hmisc package
cor_matrix_with_p <- rcorr(as.matrix(student_data_cor), type = "pearson")
print(cor_matrix_with_p$r)  # Correlation coefficients
print(cor_matrix_with_p$P)  # p-values

# Step 3: Visualize the Correlation Matrix
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

