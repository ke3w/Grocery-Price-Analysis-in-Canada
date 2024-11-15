#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state and party that won each division.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
# State names
vendors <- c("Voila", 
             "TandT", 
             "Loblaws", 
             "No Frills", 
             "Metro", 
             "Galleria", 
             "Walmart", 
             "SaveOnFoods")

simulated_data <- tibble(
  vendor = sample(vendors, size = 1000, replace = TRUE),
  current_price = round(runif(1000, 0, 480), 3),
  old_price = round(runif(1000, 0, 1000), 3)
)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
