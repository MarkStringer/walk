#! /bin/bash
perl sort.pl > out.csv
perl bestfit.pl out.csv > fit.csv
`bash weightFit.sh`
`bash weekWeightFit.sh`
gnuplot twoaxes.gnu
firefox file.svg&
