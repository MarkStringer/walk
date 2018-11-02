#! /bin/bash
perl sort.pl > out.csv
perl bestfit.pl out.csv > fit.csv
`bash weightFit.sh`
`bash weekWeightFit.sh`
#gnuplot twoaxes.gnu

## badges and rankings
./wagon_badge  7
./wagon_badge 14
./week_rank

## show the graph
read -n1 -r -p "Show Graph? [Y]/N" key
if [[ "$key" =~ ^([nN]+$) ]]
then
	exit 0
else
	firefox file.svg&	
fi
