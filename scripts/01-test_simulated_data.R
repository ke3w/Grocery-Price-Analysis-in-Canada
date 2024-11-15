#### Preamble ####
# Purpose: Tests the structure and validity of the simulated grocery pricing dataset.
# Author: Xinze Wu
# Date: [Today's Date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run to create the simulated data file
# Additional Information: Ensure you are in the `starter_folder` R project


#### Workspace setup ####
library(tidyverse)

# Load the simulated data
analysis_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 1000 rows
if (nrow(analysis_data) == 1000) {
  message("Test Passed: The dataset has 1000 rows.")
} else {
  stop("Test Failed: The dataset does not have 1000 rows.")
}

# Check if the dataset has 3 columns
if (ncol(analysis_data) == 3) {
  message("Test Passed: The dataset has 3 columns.")
} else {
  stop("Test Failed: The dataset does not have 3 columns.")
}


# Check if 'current_price' and 'old_price' columns have only numeric values
if (is.numeric(analysis_data$current_price) && is.numeric(analysis_data$old_price)) {
  message("Test Passed: The 'current_price' and 'old_price' columns contain only numeric values.")
} else {
  stop("Test Failed: The 'current_price' and/or 'old_price' columns contain non-numeric values.")
}

# Check if all values in 'current_price' and 'old_price' columns are non-negative
if (all(analysis_data$current_price >= 0) && all(analysis_data$old_price >= 0)) {
  message("Test Passed: All values in 'current_price' and 'old_price' are non-negative.")
} else {
  stop("Test Failed: There are negative values in 'current_price' or 'old_price'.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if 'vendor' column has at least two unique values
if (n_distinct(analysis_data$vendor) >= 2) {
  message("Test Passed: The 'vendor' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'vendor' column contains less than two unique values.")
}

# Check if the 'current_price' is generally lower than 'old_price' (indicative of sales)
if (mean(analysis_data$current_price < analysis_data$old_price) > 0.5) {
  message("Test Passed: More than half of 'current_price' values are lower than 'old_price', indicating sales.")
} else {
  message("Note: Less than half of 'current_price' values are lower than 'old_price', sales might be infrequent.")
}
