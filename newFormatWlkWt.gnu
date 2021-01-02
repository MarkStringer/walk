set terminal svg enhanced size 800,600
set output 'file.svg'
set title "Actual Progress" font "Serif,32"

set key left
set timefmt "%Y%m%d"
set format x "%d-%b-%y"
set xdata time
set xrange ["20210101":"20211231"]
set yrange [85:120]
set y2range [-200:1600]
set y2tics "-200", 100, "1600"
set xtics font ", 16"
set xtics rotate by 45 right
set xtics nomirror "20210101",2592000, "20211231" 
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
set style line 9 lt 1 lc rgb '#00ff00' # greengreen
set style line 10 lt 1 lc rgb '#00ff00' #redred
set style line 11 lt 1 lc rgb '#0000ff' #blueblue


# palette
set palette maxcolors 11 
set palette defined ( 0 '#e6194B',\
    	    	      1 '#D95F02',\
		      2 '#808000',\
		      3 '#bfef45',\
		      4 '#3cb44b',\
		      5 '#42d4f4',\
		      6 '#000075',\
		      7 '#f032e6',\
		      8 '#00ff00',\
                      9 '#ff0000',\
                      10 '#0000ff')

f(x)=a+b*x
a = 1
b = 1e-8
fit [strptime("%Y%m%d","20180101"):strptime("%Y%m%d","20211231")] f(x) datafile u 1:2 via a,b

g(x)= p+q*x
p = 1
q = 1e-8
fit [strptime("%Y%m%d","20180101"):strptime("%Y%m%d","20211231")] g(x) recent u 1:2 via p,q	

h(x)= r+s*x
r = 1
s = 1e-8
fit [strptime("%Y%m%d","20210101"):strptime("%Y%m%d","20211231")] h(x) "walk.csv" u 1:3 via r,s

plot \
"weight.csv"                   using 1:2 axes x1y1 with lines ls 10 title "Weight" ,\
f(x) with lines ls 1 dt 3 title 'Expected Weight' , \
g(x) with lines ls 2 dt 3 title 'Recent Weight Trend' , \
"weight2018.csv"	       using 1:2 axes x1y1 with lines ls 1 title "Weight 2018", \
"weight2019.csv"	       using 1:2 axes x1y1 with lines ls 2 title "Weight 2019", \
"weight2020.csv"               using 1:2 axes x1y1 with lines ls 7 title "Weight 2020", \
"walk.csv"                     using 1:3 axes x1y2 with lines ls 3 title "Walk" , \
"walk2018.csv"		       using 1:3 axes x1y2 with lines ls 4 title "Walk 2018", \
"walk2019.csv"		       using 1:3 axes x1y2 with lines ls 5 title "Walk 2019", \
"walk2020.csv"                 using 1:3 axes x1y2 with lines ls 8 title "Walk 2020", \
"themis.csv"                   using 1:3 axes x1y2 with lines ls 11 title "Themis walk 2021", \
"LinearTarget.csv"	       using 1:2 axes x1y2 with lines ls 6 dt 3 title "Target 2021", \
h(x) axes x1y2 with lines ls 9 dt 3 title "Walk Fit"

t = sprintf ("%8.10f", s);

print t;
