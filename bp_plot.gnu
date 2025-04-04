
set terminal pngcairo size 800,600 enhanced font 'Verdana,10'
set output 'bp_plot.png'

set xdata time
set timefmt "%Y-%m-%d"
set format x "%Y-%m-%d"
set xtics rotate by -45

set title "Blood Pressure Over Time"
set xlabel "Date"
set ylabel "Blood Pressure (mmHg)"

set grid
plot "bp_data.dat" using 1:2 with linespoints title "Systolic", \
     "bp_data.dat" using 1:3 with linespoints title "Diastolic"
