#! /usr/bin/bash
python3 split_sugar.py 
gnuplot plot_split.gnuplot 
ffx sugar_plot.png 
