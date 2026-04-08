# Inspired by https://fruttenboel.nl/obc/movavg.html
# Expected columns:
#   1 = date in YYYYMMDD
#   2 = systolic
#   3 = diastolic
#   4 = pulse
#
# Runtime variables (can be passed with -e):
#   datafile, avgfile, outfile, window

if (!exists("datafile")) datafile = "bp.csv"
if (!exists("avgfile"))  avgfile  = datafile . ".avg"
if (!exists("outfile"))  outfile  = "bp_chart.png"
if (!exists("window"))   window   = 5

set terminal pngcairo size 1400,800 enhanced
set output outfile

set title sprintf("Blood pressure and pulse with %d-sample running average", window)
set datafile separator whitespace
set xdata time
set timefmt "%Y%m%d"
set format x "%Y-%m-%d"
set xlabel "Date"
set ylabel "Blood pressure (mmHg)"
set y2label "Pulse (bpm)"
set y2tics
set ytics nomirror
set grid xtics ytics y2tics
set key outside bottom center horizontal
set border linewidth 1.2
set tics out
set xtics rotate by 35 right
set pointsize 0.8

# Raw values: linespoints
# Running averages: thicker lines only
set style line 1 lt 1 lw 1.2 pt 7
set style line 2 lt 2 lw 1.2 pt 5
set style line 3 lt 3 lw 1.2 pt 9
set style line 11 lt 1 lw 2.8
set style line 12 lt 2 lw 2.8
set style line 13 lt 3 lw 2.8

plot \
  datafile using 1:2 with linespoints ls 1 title "Systolic", \
  avgfile  using 1:2 with lines       ls 11 title sprintf("Systolic avg (%d)", window), \
  datafile using 1:3 with linespoints ls 2 title "Diastolic", \
  avgfile  using 1:3 with lines       ls 12 title sprintf("Diastolic avg (%d)", window), \
  datafile using 1:4 axes x1y2 with linespoints ls 3 title "Pulse", \
  avgfile  using 1:4 axes x1y2 with lines       ls 13 title sprintf("Pulse avg (%d)", window)
