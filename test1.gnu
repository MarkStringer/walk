##set terminal png size 800,600 enhanced font "Serif,10"
##set output 'output.png'
set terminal svg enhanced size 800,600
set output 'test.svg'

f(x) = A0*exp(-x/tau)
A0=1000;tau=1
plot 'exp.dat' u 1:2:(sqrt($2)) w yerr, f(x)

set title 'Gnuplot Example'
set ylabel 'Counts'
set xlabel 'Times (ms)'
replot
fit f(x) 'exp.dat' u 1:2 via A0, tau
plot 'exp.dat' u 1:2:(sqrt($2)) w yerr, f(x)
