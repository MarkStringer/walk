perl dateFit.pl weight.csv > output.csv
gnuplot getStats.gnu &> out.txt
perl weightFit.pl `tail -1 out.txt` > weightFit.csv 

