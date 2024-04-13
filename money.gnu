set terminal svg enhanced size 800,600
set output 'file.svg'
set title "Actual Progress" font "Serif,32"

set timefmt "%Y%m%d"
set format x "%d-%b-%y"
set xdata time
set xrange ["20190501":"20190731"]
set yrange [0:6000]
set xtics font ", 16"
set xtics rotate by 45 right
set xtics nomirror "20190101",2592000, "20191231" 
set mxtics 4
set ytics nomirror 

set colorsequence classic

set style line 1 lt 1 lw 2 pt 3 ps 0.5
set style line 2 lt 2 lw 2 pt 3 ps 0.5
set style line 3 lt 3 lw 2 pt 3 ps 0.5
set style line 4 lt 4 lw 2 pt 3 ps 0.5
set style line 5 lt 5 lw 2 pt 3 ps 0.5
set style line 6 lt 6 lw 2 pt 3 ps 0.5
set style line 7 lt 7 lw 2 pt 3 ps 0.5
set style line 8 lt 8 lw 2 pt 3 ps 0.5

plot "money.csv"                   using 1:2 axes x1y1 with lines ls 3 title "money" 
