#! /bin/bash
perl sort.pl > walk.csv
tail -n 7 weight.csv > recent.csv
##perl sort.pl | grep Themis > preThemis.csv
##perl processThemis.pl > themis.csv
gnuplot -e "datafile='weight.csv';recent='recent.csv'" newFormatWlkWt.gnu

# show the graph
read -n1 -r -p "Show Graph? [Y]/N" key
if [[ "$key" =~ ^([nN]+$) ]]
then
	exit 0
else
	`ffx ${GRAPH_PATH}`&	
fi
./commit.sh
