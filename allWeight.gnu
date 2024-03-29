set terminal svg enhanced size 800,600
set output 'file.svg'
set title "Actual Progress" font "Serif,32"

set key left
set timefmt "%Y%m%d"
set format x "%d-%b-%y"
set xdata time
set xrange ["20180101":"20221231"]
set yrange [85:120]
set y2range [-200:1800]
set y2tics "-200", 100, "1800"
set xtics font ", 16"
set xtics rotate by 45 right
set xtics nomirror "20180101",25920000, "20221231" 
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



plot \
"weight_xls2.csv"                   using 1:2 axes x1y1 with lines ls 1 title "Weight" ,\
