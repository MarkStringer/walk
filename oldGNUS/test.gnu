##set terminal png size 800,600 enhanced font "Serif,10"
##set output 'output.png'
set terminal svg enhanced size 800,600
set output 'file.svg'
set xdata time
set timefmt "%d/%m/%Y"
set xtics rotate
set xrange ["01/01/2018":"31/12/2018"]
set xtics "01/01/2018", 1209600, "31/12/2018"
set style line 1 lt 1 lw 2 pt 3 ps 0.5 
set style line 2 lt 2 lw 2 pt 3 ps 0.5
set style line 3 lt 3 lw 2 pt 3 ps 0.5
set style line 4 lt 4 lw 2 pt 3 ps 0.5
plot "out.csv" using 1:3 with lines ls 1 title "Actual" , \
"MonthlyTargets.txt" using 1:2 with lines ls 2 title "Target" , \
"LinearTarget.txt" using 1:2 with lines ls 3 title "Linear" , \
"fit.csv" using 1:2 with lines ls 4 title "Best Fit"
