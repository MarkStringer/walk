set terminal svg enhanced size 800,600
set output 'file.svg'
set y2range [-200:1400]
set yrange [85:120]
set xdata time
set timefmt "%d/%m/%Y"
set format x "%d/%m/%Y" 
set xtics rotate
set xrange ["01/01/2018":"31/12/2018"]
set xtics nomirror "01/01/2018", 1209600, "31/12/2018"
set y2tics "-200", 100, "1400"
set ytics nomirror
set style line 1 lt 1 lw 2 pt 3 ps 0.5
set style line 2 lt 2 lw 2 pt 3 ps 0.5
set style line 3 lt 3 lw 2 pt 3 ps 0.5
set style line 4 lt 4 lw 2 pt 3 ps 0.5
set style line 5 lt 8 lw 2 pt 3 ps 0.5
set style line 6 lt 6 lw 2 pt 3 ps 0.5
set style line 7 lt 7 lw 2 pt 3 ps 0.5
set datafile commentschars "#!%"

plot "out.csv"                 using 1:3 axes x1y2 with lines ls 1 title "Actual" ,  \
"MonthlyTargets.txt"           using 1:2 axes x1y2 with lines ls 2 title "Target" ,  \
"LinearTarget.txt"             using 1:2 axes x1y2 with lines ls 3 title "Linear" ,  \
"fit.csv"                      using 1:2 axes x1y2 with lines ls 4 title "Best Fit", \
"weight.csv"                   using 1:2 axes x1y1 with lines ls 7 title "Weight", \
"weightFit.csv"		       using 1:2 axes x1y1 with lines ls 6 title "Weight Best Fit", \
"weekWeightFit.csv"	       using 1:2 axes x1y1 with lines ls 5 title "Week Weight Best Fit"

