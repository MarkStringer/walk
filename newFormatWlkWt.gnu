set terminal svg enhanced size 800,600
set output 'file.svg'
set title "Actual Progress" font "Serif,32"

set timefmt "%Y%m%d"
set format x "%d-%b-%y"
set xdata time
set xrange ["20200101":"20210131"]
set yrange [85:120]
set y2range [-200:1400]
set y2tics "-200", 100, "1400"
set xtics font ", 16"
set xtics rotate by 45 right
set xtics nomirror "20200101",2592000, "20201231" 
set mxtics 4
set ytics nomirror 

# line styles
set style line 1 lt 1 lc rgb '#e6194B' # red
set style line 2 lt 1 lc rgb '#f58231' # orange
set style line 3 lt 1 lc rgb '#808000' # olive
set style line 4 lt 1 lc rgb '#bfef45' # lime
set style line 5 lt 1 lc rgb '#3cb44b' # green
set style line 6 lt 1 lc rgb '#42d4f4' # cyan
set style line 7 lt 1 lc rgb '#000075' # navy
set style line 8 lt 1 lc rgb '#f032e6' # magenta

# palette
set palette maxcolors 8
set palette defined ( 0 '#e6194B',\
    	    	      1 '#D95F02',\
		      2 '#808000',\
		      3 '#bfef45',\
		      4 '#3cb44b',\
		      5 '#42d4f4',\
		      6 '#000075',\
		      7 '#f032e6' )

f(x)=a+b*x
a = 1
b = 1e-8
fit [strptime("%Y%m%d","20180101"):strptime("%Y%m%d","20201231")] f(x) datafile u 1:2 via a,b

g(x)= p+q*x
p = 1
q = 1e-8
fit [strptime("%Y%m%d","20180101"):strptime("%Y%m%d","20201231")] g(x) recent u 1:2 via p,q	

h(x)= r+s*x
r = 1
s = 1e-8
fit [strptime("%Y%m%d","20200101"):strptime("%Y%m%d","20201231")] h(x) "walk.csv" u 1:3 via r,s

plot \
"weight.csv"                   using 1:2 axes x1y1 with lines ls 8 title "Weight" ,\
f(x) with lines ls 1 dt 3 title 'Expected Weight' , \
g(x) with lines ls 2 dt 3 title 'Recent Weight Trend' , \
"weight2018.csv"	       using 1:2 axes x1y1 with lines ls 1 title "Weight 2018", \
"weight2019.csv"	       using 1:2 axes x1y1 with lines ls 2 title "Weight 2019", \
"walk.csv"                     using 1:3 axes x1y2 with lines ls 3 title "Walk" , \
"walk2018.csv"		       using 1:3 axes x1y2 with lines ls 4 title "Walk 2018", \
"walk2019.csv"		       using 1:3 axes x1y2 with lines ls 5 title "Walk 2019", \
"LinearTarget.csv"	       using 1:2 axes x1y2 with lines ls 6 dt 3 title "Target 2020", \
h(x) axes x1y2 with lines ls 7 dt 3 title "Walk Fit"

t = sprintf ("%8.10f", s);

print t;
