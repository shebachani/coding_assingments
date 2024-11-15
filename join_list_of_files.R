#!/usr/bin/env Rscript

# Load required libraries
suppressPackageStartupMessages(library(dplyr))
library(readr)
library(purrr)

# Function to read and merge the files
join_files <- function(file_list_path) {
  
  # Read the file containing the list of file paths
  file_list <- read_lines(file_list_path)
  
  # Read each file and store them in a list
  files <- map(file_list, ~ read_tsv(.x, show_col_types = FALSE))
  
  # Ensure that each file has the correct column for 'UUID' (rename if necessary)
  files <- map(files, ~ {
    colnames(.x)[1] <- "UUID"  # Rename the first column to UUID (if it's not already)
    return(.x)
  })
  
  # Perform the inner join across all files using 'reduce'
  merged_data <- reduce(files, ~ inner_join(.x, .y, by = "UUID"))
  
  # Sort the data by UUID (or any other column you wish to sort by)
  merged_data <- merged_data %>% arrange(UUID)
  
  # Write the merged data to stdout in a plain format (without tibble formatting)
  write_tsv(merged_data, file = stdout(), col_names = FALSE)
}

# Get the path of the file containing the list of input files
args <- commandArgs(trailingOnly = TRUE)

# Ensure that we have the file list argument
if (length(args) != 1) {
  stop("Error: Please provide the path to the file containing the list of input files.")
}

# Call the function with the file list path
join_files(args[1])

