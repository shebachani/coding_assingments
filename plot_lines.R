# Add necessary libraries
library(ggplot2)
library(tidyr)

# Get command-line arguments
args <- commandArgs(trailingOnly=TRUE)
output_file <- args[1]
x_label <- args[2]
y_label <- args[3]
plot_title <- args[4]

# Read data from stdin without headers
data <- read.table(file("stdin"), header=FALSE)

# Assign column names manually
colnames(data) <- c("Position", "Value", "Cluster")

# Check if the Position column exists and handle if missing
if(!"Position" %in% colnames(data)) {
  stop("Position column is missing from the data.")
}

# Ensure Position column is of type character or numeric
data$Position <- as.character(data$Position)

# Reshape the 'Value' column to long format and keep 'Cluster' intact
data_long <- pivot_longer(data, 
                          cols = "Value",  # Only pivot the numeric column 'Value'
                          names_to = "Category", 
                          values_to = "Y_value")

# Add the 'Cluster' column as it is
data_long$Cluster <- data$Cluster

# Create the plot
p <- ggplot(data_long, aes(x=Position, y=Y_value, color=Cluster)) +  # Use 'Cluster' as the color
    geom_point() +
    labs(x=x_label, y=y_label, title=plot_title) +
    theme_minimal()

# Save the plot
ggsave(output_file, plot=p, width=8, height=6)

