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

f(x)=a+b*x
a = 1
b = 1 
fit [strptime("%d/%m/%Y","09/04/2018"):strptime("%d/%m/%Y","01/03/2019")] f(x) "out.csv" u 1:3 via a,b

g(x)=c+d*x
c = 1
d = 1e-8
fit [strptime("%d/%m/%Y","09/04/2018"):strptime("%d/%m/%Y","01/03/2019")] g(x) "weight.csv" u 1:2 via c,d

plot "out.csv"                 using 1:3 axes x1y2 with lines ls 1 title "Actual" ,  \
"MonthlyTargets.txt"           using 1:2 axes x1y2 with lines ls 2 title "Target" ,  \
"LinearTarget.txt"             using 1:2 axes x1y2 with lines ls 3 title "Linear" ,  \
"weight.csv"                   using 1:2 axes x1y1 with lines ls 7 title "Weight" ,  \
f(x)                           with lines ls 6 title "Walk Line Fit" , \
g(x)                           with lines ls 8 title "Weight Fit"

