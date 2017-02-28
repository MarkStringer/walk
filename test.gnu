set terminal png size 800,600 enhanced font "Helvetica,20"
set output 'output.png'
set xdata time
set timefmt "%d/%m/%Y"
set xtics rotate 
set xtics font ", 10"
set xtics "01/01/2017",604800,"01/04/2017"
plot "out.csv" using 1:3 with lines title "Actual" , \
"MonthlyTargets.txt" using 1:2 with lines title "Target"
