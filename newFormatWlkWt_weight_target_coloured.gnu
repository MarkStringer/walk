
# line styles for clarity
set style line 1 lt 1 lc rgb '#e6194B' lw 2 # Weight (red solid)
set style line 2 lt 2 lc rgb '#0000FF' lw 2 # Prediction (blue dashed)
set style line 12 lt 3 lc rgb '#000000' lw 2 # Target (black dotted)

set terminal svg enhanced size 800,600
set output 'file.svg'
set title "Actual Progress" font "Serif,32"

set key left
set timefmt "%Y%m%d"
set format x "%d-%b-%y"
set xdata time
set xrange ["20250101":"20261231"]
set yrange [85:120]
set y2range [-200:1800]
set y2tics "-200", 100, "1800"
set xtics font ", 16"
set xtics rotate by 45 right
set xtics nomirror "20250101",2592000, "20261231" 
set mxtics 4
set ytics nomirror 

# line styles


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

# Target line setup
stats "weight.csv" using 1:2 nooutput
last_date = STATS_max_x
last_weight = STATS_last_y

target_date = strptime("%Y%m%d","20261231")
target_weight = 85

target(x) = last_weight + (target_weight-last_weight)*(x-last_date)/(target_date-last_date)

a = 1
b = 1e-8
fit [strptime("%Y%m%d","20180101"):strptime("%Y%m%d","20261231")] f(x) datafile u 1:2 via a,b

p = 1
q = 1e-8

r = 1
s = 1e-8 

j = 1
k = 1e-8



plot \
"weight.csv" using 1:2 axes x1y1 with lines ls 1 title "Weight" ,\
f(x) with lines ls 2 dt 3 title 'Expected Weight' ,\
target(x) with lines ls 3 dt 2 title 'Target 85kg'
"weight.csv"                   using 1:2 axes x1y1 with lines ls 1 title "Weight" ,\
f(x) with lines ls 2 dt 3 title 'Expected Weight' , \

t = sprintf ("%8.10f", s);

print t;