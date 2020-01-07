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
set style line 1 lt 1 lc rgb '#1B9E77' # dark teal
set style line 2 lt 1 lc rgb '#D95F02' # dark orange
set style line 3 lt 1 lc rgb '#7570B3' # dark lilac
set style line 4 lt 1 lc rgb '#E7298A' # dark magenta
set style line 5 lt 1 lc rgb '#66A61E' # dark lime green
set style line 6 lt 1 lc rgb '#E6AB02' # dark banana
set style line 7 lt 1 lc rgb '#A6761D' # dark tan
set style line 8 lt 1 lc rgb '#666666' # dark gray

# palette
set palette maxcolors 8
set palette defined ( 0 '#1B9E77',\
    	    	      1 '#D95F02',\
		      2 '#7570B3',\
		      3 '#E7298A',\
		      4 '#66A61E',\
		      5 '#E6AB02',\
		      6 '#A6761D',\
		      7 '#666666' )

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
"weight.csv"                   using 1:2 axes x1y1 with lines ls 1 title "Weight" ,\
f(x) with lines ls 1 title 'Expected Weight' , \
g(x) with lines ls 2 title 'Recent Weight Trend' , \
"weight2018.csv"	       using 1:2 axes x1y1 with lines ls 2 title "Weight 2018", \
"weight2019.csv"	       using 1:2 axes x1y1 with lines ls 3 title "Weight 2019", \
"walk.csv"                     using 1:3 axes x1y2 with lines ls 4 title "Walk" , \
"walk2018.csv"		       using 1:3 axes x1y2 with lines ls 5 title "Walk 2018", \
"walk2019.csv"		       using 1:3 axes x1y2 with lines ls 6 title "Walk 2019", \
"LinearTarget.csv"	       using 1:2 axes x1y2 with lines ls 7 dt 3 title "Target 2020", \
h(x) axes x1y2 with lines ls 8 dt 2 title "Walk Fit"

t = sprintf ("%8.10f", s);

print t;
