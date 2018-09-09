#! /bin/bash
days=`date +%j`
daysLeft=`calc 365 - $days`
perl sort.pl > out
milesWalkedLine=`tail -n 1 out`
echo $milesWalkedLine | perl -nle 's/.*\D+(\d+\.\d+)/$1/; print $1'
