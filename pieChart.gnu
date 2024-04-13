set terminal svg enhanced size 800,600
set output 'pie.svg'
set title "Actual consumption" font "Serif,32"

set timefmt "%Y%m%d"
set format x "%d-%b-%y"
set xdata time
set xrange ["20220630":"20221231"]
set yrange [0:24]

set label "\U+1F967" at "20220716", 12 

plot "meals.dat" using 1:2
