#### Preamble ####
# Purpose: Cleans and combines the raw and product data from the grocery dataset
# Author: [Your Name]
# Date: [Today's Date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: 
# - Filtered raw_data.csv and product_data.csv should exist in "inputs/data"
# - Required packages (`tidyverse`, `janitor`, `stringr`) should be installed
# Additional Information: Combined and cleaned data will be saved in CSV format for analysis.

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(stringr)

#### Clean and Combine Data ####

# Load the filtered raw data
raw_data <- read_csv("data/01-raw_data/filtered_raw_data.csv")

# Load the product data
product_data <- read_csv("data/01-raw_data/product_data.csv")

# Clean column names for both datasets
raw_data <- janitor::clean_names(raw_data)
product_data <- janitor::clean_names(product_data)

# Join raw_data and product_data on 'product_id' and 'id' columns
combined_data <- raw_data |>
  left_join(product_data, by = c("product_id" = "id"))

# Identify and remove rows with non-numeric prices
# Also remove any unwanted characters in current_price and old_price
cleaned_data <-
  combined_data |>
  filter(!is.na(as.numeric(str_replace_all(current_price, "[^0-9.]", ""))) &
           !is.na(as.numeric(str_replace_all(old_price, "[^0-9.]", "")))) |>
  mutate(
    # Remove any non-numeric characters from prices and convert to numeric
    current_price = as.numeric(str_replace_all(current_price, "[^0-9.]", "")),
    old_price = as.numeric(str_replace_all(old_price, "[^0-9.]", "")),
    discount_applied = if_else(current_price < old_price, TRUE, FALSE)
  ) |>
  select(
    vendor,
    product_name,
    brand,
    units,
    current_price,
    old_price,
    discount_applied
  ) |>
  rename(
    product = product_name,
    price = current_price,
    original_price = old_price
  ) |>
  drop_na()  # Drop any rows with remaining missing values

#### Save Combined Data ####
# Save the cleaned and combined data to the outputs folder
write_csv(cleaned_data, "data/02-analysis_data/combined_cleaned_grocery_data.csv")
