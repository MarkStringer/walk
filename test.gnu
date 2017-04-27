set terminal png size 800,600 enhanced font "Helvetica,10"
set output 'output.png'
set xdata time
set timefmt "%d/%m/%Y"
set xtics rotate 
set xtics font "Helvetica,10"
plot "out.csv" using 1:3 with lines title "Actual" , \
"MonthlyTargets.txt" using 1:2 with lines title "Target"
