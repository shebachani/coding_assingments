# Set the terminal to PostScript with specified size and font
set terminal postscript eps enhanced size 6,10 font 'Arial, 15'

# Specify the output file
set output "Q5_output/q1_data_heatmap.eps"

# Define a color palette with RGB values
set palette defined (0 "#FFFFFF", 0.3 "#FFB6C1", 0.7 "#FF0000", 1 "#800000")

# Enable pm3d mode with map projection for 2D heatmap
set pm3d map

# Customize the color bar on the right
set colorbox vertical user origin 0.9, 0.2 size 0.03, 0.6

# Set the color range for the heatmap
set cbrange [0.5:1.5]

# Set the title for the plot
set title "MNase" offset 0,-2

# Remove x-axis and y-axis labels and ticks for a cleaner appearance
unset xtics
unset ytics

# Add horizontal lines to separate clusters at specific row indices
# Assume the clusters are separated at rows 50, 100, 150, etc. (adjust based on your data)
set arrow from 0, 50 to 250, 50 nohead lc rgb "black" lw 1
set arrow from 0, 100 to 250, 100 nohead lc rgb "black" lw 1
set arrow from 0, 150 to 250, 150 nohead lc rgb "black" lw 1
set arrow from 0, 200 to 250, 200 nohead lc rgb "black" lw 1

# Plot the data from the matrix file
splot "Q5_output/q1_matrix.tsv" matrix with image

