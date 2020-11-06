perl dateFit.pl weight.csv > output.csv
echo "$(tail -n 7 output.csv)" > output.csv
gnuplot getStats.gnu &> out.txt
perl weightFit.pl `tail -1 out.txt` > weekWeightFit.csv 

