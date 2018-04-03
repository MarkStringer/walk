set terminal svg enhanced size 800,600
set output 'file.svg'

set yrange [-200:1200]
set y2range [0:120]
set autoscale y

set y2tics 10

set xdata time
set timefmt "%d/%m/%Y"
set xtics rotate
set xrange ["01/01/2018":"31/12/2018"]
set xtics "01/01/2018", 1209600, "31/12/2018"
set style line 1 lt 1 lw 2 pt 3 ps 0.5
set style line 2 lt 2 lw 2 pt 3 ps 0.5
set style line 3 lt 3 lw 2 pt 3 ps 0.5
set style line 4 lt 4 lw 2 pt 3 ps 0.5
set style line 5 lt 5 lw 2 pt 3 ps 0.5

plot "out.csv" using 1:3 with lines ls 1 title "Actual" , \
"MonthlyTargets.txt" using 1:2 axes x1y1 with lines ls 2 title "Target" , \
"LinearTarget.txt" using 1:2 axes x1y1 with lines ls 3 title "Linear" , \
"fit.csv" using 1:2 axes x1y1 with lines ls 4 title "Best Fit", \
"weight.csv" using 1:2 axes x1y2 with lines ls 5 title "Weight"

