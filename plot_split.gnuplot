# gnuplot script for fasting.csv and postpradial.csv
# Assumes both files are tab-separated with:
#   1: date in YYYYMMDD format
#   2: numeric value
#   3: label text
#
# Run:
#   python3 split_sugar.py
#   gnuplot plot_split.gnuplot

set terminal pngcairo size 1000,600
set output "sugar_plot.png"

set title "Fasting vs Postprandial"
set xlabel "Date"
set ylabel "Value"

set xdata time
set timefmt "%Y%m%d"
set format x "%Y-%m-%d"
set xtics rotate by 45

set key top right
set grid
set datafile separator "\t"

plot \
    'fasting.csv' using 1:2 smooth unique with linespoints title 'Fasting', \
    'postprandial.csv' using 1:2 smooth unique with linespoints title 'Postprandial'
