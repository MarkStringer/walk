#! /bin/bash
perl sort.pl > walk.csv
tail -n 7 weight.csv > recent.csv
perl sort.pl | grep Themis > preThemis.csv
perl processThemis.pl > themis.csv
perl cleanWalk.pl > clean.csv
gnuplot -e "datafile='weight.csv';recent='recent.csv';clean='clean.csv'" newFormatWlkWt.gnu

# show the graph
read -n1 -r -p "Show Graph? [Y]/N" key
if [[ "$key" =~ ^([nN]+$) ]]
then
	exit 0
else
	ffx file.svg&	
fi
./commit.sh
