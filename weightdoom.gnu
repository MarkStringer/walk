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
b = 1e-8
fit [strptime("%d/%m/%Y","01/03/2018"):strptime("%d/%m/%Y","01/03/2039")] f(x) "weight.csv" u 1:2 via a,b

plot "weight.csv" using 1:2 with lines ls 7 title 'Weight',\
     f(x) with lines ls 4 dt 3 title 'Expected Weight'

##a = 1
##b = 1e-8
##fit [strptime("%Y%m%d","20180601"):strptime("%Y%m%d","21390801")] f(x) datafile u 1:2 via a,b
##
##a2 = 1
##b2 = 1
##f2(x) = a2 + b2 * x
##fit [strptime("%Y%m%d","20180601"):strptime("%Y%m%d","21390801")] f2(x) datafile u 1:3 via a2, b2
##
##fmt = '%Y-%m-%d'
##doomsday = strftime(fmt, (a2 - a) /(b - b2))
##
##set label 1 "Burnup predictect to complete at:".doomsday at "20181231", 800
##
##plot datafile using 1:2 with lines ls 7 title 'Done',\
##     f(x) with lines ls 4 dt 3 title 'Expected Done', \
##     f2(x) with lines ls 3 dt 4 title 'Expected Backlog', \
##datafile using 1:3 with lines ls 6 title "Total Backlog"
##
