#! /bin/bash
git pull
add *rank*
add *.pl
add *badge*
git add walk*.txt
git add *.sh
git add weight.csv
git add *.gnu
git add *.yaml
git commit -m "Add walks and weight loss ${@}"
git push
