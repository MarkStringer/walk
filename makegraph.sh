#! /usr/bin/bash
GRAPH_PATH=/home/mark/projects/walk

# Check if GRAPH_PATH environment variable is set
if [[ -z "${GRAPH_PATH}" ]]; then
    read -p "Please enter the path to the SVG file: " GRAPH_PATH
    export GRAPH_PATH
fi

perl sort.pl > walk.csv
tail -n 7 weight.csv > recent.csv
tail -n 7 walk.csv > recentWalk.csv
gnuplot -e "datafile='weight.csv';recent='recent.csv'" newFormatWlkWt.gnu

# show the graph
read -n1 -r -p "Show Graph? [Y]/N: " key
if [[ "$key" =~ ^([nN]+$) ]]; then
    exit 0
else
    ffx "file://${GRAPH_PATH}/file.svg" &
fi
./commit.sh
