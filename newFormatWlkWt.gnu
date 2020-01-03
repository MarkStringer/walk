set terminal svg enhanced size 800,600
set output 'file.svg'
set title "Actual Progress" font "Serif,32"

set timefmt "%Y%m%d"
set format x "%d-%b-%y"
set xdata time
set xrange ["20200101":"20201231"]
set yrange [85:120]
set y2range [-200:1400]
set y2tics "-200", 100, "1400"
set xtics font ", 16"
set xtics rotate by 45 right
set xtics nomirror "20200101",2592000, "20201231" 
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

f(x)=a+b*x
a = 1
b = 1e-8
fit [strptime("%Y%m%d","20180101"):strptime("%Y%m%d","20200101")] f(x) datafile u 1:2 via a,b

g(x)= p+q*x
p = 1
q = 1e-8
fit [strptime("%Y%m%d","20180101"):strptime("%Y%m%d","20200101")] g(x) recent u 1:2 via p,q	

h(x)= r+s*x
r = 1
s = 1e-8
fit [strptime("%Y%m%d","20200101"):strptime("%Y%m%d","20201231")] h(x) "walk.csv" u 1:3 via r,s

plot \
f(x) with lines ls 1 dt 2 title 'Expected Weight' , \
g(x) with lines ls 2 dt 2 title 'Recent Trend' , \
"weight.csv"                   using 1:2 axes x1y1 with lines ls 3 title "Weight" ,\
"weight2018.csv"	       using 1:2 axes x1y1 with lines ls 4 title "Weight 2018", \
"walk.csv"                     using 1:3 axes x1y2 with lines ls 5 title "Walk" , \
"walk2018.csv"		       using 1:3 axes x1y2 with lines ls 6 title "Walk 2018", \
"walk2019.csv"		       using 1:3 axes x1y2 with lines ls 2 title "Walk 2019", \
"LinearTarget.csv"	       using 1:2 axes x1y2 with lines ls 7 dt 3 title "Target 2018", \
h(x) axes x1y2 with lines ls 8 dt 2 title "Walk Fit"

t = sprintf ("%8.10f", s);

print t;
