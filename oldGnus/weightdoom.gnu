set terminal svg enhanced size 800,600
set output 'file.svg'
set yrange [0:200]
set xdata time
set timefmt "%d/%m/%Y"
set format x "%d/%m/%Y" 
set xtics rotate
set xrange ["01/01/2018":"31/12/2018"]
set xtics nomirror "01/01/2018", 1209600, "31/12/2018"
set ytics mirror
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
fit [strptime("%d/%m/%Y","09/04/2018"):strptime("%d/%m/%Y","01/03/2039")] f(x) "weight.csv" u 1:2 via a,b

fmt = '%d/%m/%Y'
doomsday = strftime(fmt, (85 - a) /b)

g(x) = j + (k * x)
fit [strptime("%d/%m/%Y","09/04/2018"):strptime("%d/%m/%Y","01/03/2039")] g(x) "weight.csv" u 1:(log($2)) via j, k
j = -1
k = 0.001

h(x) = exp(j)*exp(k*x)

#set table "output.txt"

set label 1 "Target Weight:".doomsday at "30/06/2018", 100
plot "weight.csv" using 1:2 with lines ls 7 title 'Weight',\
     f(x) with lines ls 4 dt 3 title 'Expected Weight',\
     "weight.csv" using 1:(log($2))  with lines ls 2, \
     g(x) with lines ls 8 dt 3 title 'Exp best fit', \
     h(x) with lines ls 7 dt 3 title 'Exp exp best fit'
     

