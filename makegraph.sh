#! /bin/bash
perl sort.pl > walk.csv
#gnuplot twoaxes.gnu
tail -n 7 weight.csv > recent.csv
gnuplot -e "datafile='weight.csv';recent='recent.csv'" newFormatWlkWt.gnu

## badges and rankings
##./wagon_badge  7
##./wagon_badge 14
##./week_rank

# show the graph
read -n1 -r -p "Show Graph? [Y]/N" key
if [[ "$key" =~ ^([nN]+$) ]]
then
	exit 0
else
	firefox file.svg&	
fi
./commit.sh
