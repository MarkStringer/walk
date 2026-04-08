# gnuplot script for sugar.csv
# Assumes sugar.csv has 3 tab-separated columns:
#   1: date in YYYYMMDD format
#   2: numeric value
#   3: text code whose first character is F/f or P/p

set terminal pngcairo size 1000,600
set output "sugar_plot.png"

set title "Values split by third-column prefix"
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
    'sugar.csv' using 1:((substr(stringcolumn(3),1,1) eq "F" || substr(stringcolumn(3),1,1) eq "f") ? $2 : 1/0) \
        smooth unique with linespoints title 'Starts with "F"', \
    'sugar.csv' using 1:((substr(stringcolumn(3),1,1) eq "P" || substr(stringcolumn(3),1,1) eq "p") ? $2 : 1/0) \
        smooth unique with linespoints title 'Starts with "P"'
