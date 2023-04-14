#Assignment-2
library(tidyverse)
library(boot)

diabetes=read.csv("C:/Users/Tata Rajesh Chowdary/Desktop/PDS/Assignments/Assignment-2/data_raw/diabetes.csv")
set.seed(123)

sample_random_data <- diabetes[sample(nrow(diabetes), 25, replace = FALSE), ]
mean_glucose <- mean(sample_data$Glucose)
highest_glucose <- max(sample_data$Glucose)

population_mean_glucose <- mean(diabetes$Glucose)
population_highest_glucose <- max(diabetes$Glucose)

hist(sample_random_data$Glucose, main = "Distribution of Glucose in Sample Data", xlab = "Glucose")
abline(v = mean_glucose, col = "red", lwd = 2)

hist(diabetes$Glucose, main = "Distribution of Glucose in Population", xlab = "Glucose")
abline(v = population_mean_glucose, col = "Green", lwd = 2)


# Calculate the 98th percentile of BMI for the population
pop_percentile <- quantile(diabetes$BMI, 0.98)

# Sample 50 patients from the data and calculate their 98th percentile of BMI
set.seed(123)
sample_data <- diabetes[sample(nrow(diabetes), 50), ]
sample_percentile <- quantile(sample_data$BMI, 0.98)

# Create a histogram of BMI for the population and highlight the 98th percentile
hist(diabetes$BMI, main="BMI Distribution in Population", xlab="BMI")
abline(v=pop_percentile, col="red")

# Create a histogram of BMI for the sample and highlight the 98th percentile
hist(sample_data$BMI, main="BMI Distribution in Sample", xlab="BMI")
abline(v=sample_percentile, col="red")


#Calculate population statistics for BloodPressure
pop_mean <- mean(diabetes$BloodPressure)
pop_sd <- sd(diabetes$BloodPressure)
pop_percentile <- quantile(diabetes$BloodPressure, probs = c(0.25, 0.5, 0.75))

n_samples <- 500
sample_size <- 150
set.seed(123) # for reproducibility
samples <- lapply(1:n_samples, function(x) {
  sample(diabetes$BloodPressure, size = sample_size, replace = TRUE)
})

sample_means <- sapply(samples, mean)
sample_sds <- sapply(samples, sd)
sample_percentiles <- t(sapply(samples, function(x) quantile(x, probs = c(0.25, 0.5, 0.75))))

# Plot the distributions of BloodPressure for the population and the average means from the samples
library(ggplot2)
library(gridExtra)

pop_plot <- ggplot(diabetes, aes(x = BloodPressure)) + 
  geom_histogram(aes(y = ..density..), binwidth = 2, color = "black", fill = "white") +
  geom_density(color = "red") + 
  ggtitle("Distribution of BloodPressure in the Population")

sample_plot <- ggplot(data.frame(mean = sample_means), aes(x = mean)) + 
  geom_histogram(aes(y = ..density..), binwidth = 2, color = "black", fill = "white") +
  geom_density(color = "blue") + 
  ggtitle("Distribution of Average Means from Samples")

grid.arrange(pop_plot, sample_plot, ncol = 2)

#Compare the population statistics with the sample statistics
cat("Population Mean: ", pop_mean, "\n")
cat("Sample Mean: ", mean(sample_means), "\n\n")
cat("Population SD: ", pop_sd, "\n")
cat("Sample SD: ", mean(sample_sds), "\n\n")
cat("Population Percentiles: \n")
print(pop_percentile)
cat("\n")
cat("Sample Percentiles: \n")
print(apply(sample_percentiles, 2, mean))

