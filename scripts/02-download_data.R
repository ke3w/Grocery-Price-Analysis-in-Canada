#### Preamble ####
# Purpose: Downloads, unzips, filters, and saves specific data from Hammer project SQLite file as CSV
# Author: [Your Name]
# Date: [Today's Date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: 
# - Required packages (`httr`, `DBI`, `RSQLite`, `tidyverse`) should be installed
# - Correct URL for hammer-2-processed.zip file
# Additional Information: Only filtered data will be saved as CSV locally.

#### Workspace setup ####
library(httr)       # For downloading files
library(DBI)        # For database connections
library(RSQLite)    # For SQLite file handling
library(tidyverse)  # For data manipulation and saving
library(utils)      # For unzipping files

#### Download and Unzip the Data ####

# Define the URL for the zip file containing the SQLite database
url <- "https://jacobfilipp.com/hammerdata/hammer-3-compressed.zip"

# Define temporary paths for the zip and extracted SQLite file
temp_zip_path <- tempfile(fileext = ".zip")
temp_extract_dir <- tempfile()

# Download the zip file
download.file(url, destfile = temp_zip_path, mode = "wb")

# Unzip the downloaded file
unzip(temp_zip_path, exdir = temp_extract_dir)

# Locate the SQLite file within the unzipped folder
# Assuming it is the only .sqlite file in the directory
sqlite_files <- list.files(temp_extract_dir, pattern = "\\.sqlite$", full.names = TRUE)

# Ensure there's an SQLite file extracted
if (length(sqlite_files) == 0) {
  stop("No SQLite database found in the downloaded zip file.")
} else {
  sqlite_path <- sqlite_files[1]  # Use the first .sqlite file found
}

#### Connect to SQLite and Filter Data ####

# Connect to the extracted SQLite database
conn <- dbConnect(RSQLite::SQLite(), sqlite_path)

# List tables in the database to verify contents (optional)
db_tables <- dbListTables(conn)
print(db_tables)

# Filter and save data from the 'raw' table with an example condition
# Example: Filter rows where current_price is below 100 and save directly as CSV
if ("raw" %in% db_tables) {
  filtered_raw_data <- dbGetQuery(conn, "
    SELECT *
    FROM raw
    WHERE current_price < 100
  ")
  write_csv(filtered_raw_data, "data/01-raw_data/filtered_raw_data.csv")
  message("Filtered 'raw' data has been saved as CSV.")
}

if ("product" %in% db_tables) {
  product_data <- dbGetQuery(conn, "
    SELECT *
    FROM product
  ")
  write_csv(product_data, "data/01-raw_data/product_data.csv")
  message("The 'product' table has been saved as CSV.")
}

# Close the database connection
dbDisconnect(conn)

# Cleanup: Delete temporary files (zip file and extracted directory)
file.remove(temp_zip_path)
unlink(temp_extract_dir, recursive = TRUE)
message("Temporary files have been deleted.")
