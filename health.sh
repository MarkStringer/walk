#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# mg: generate walk/weight chart -> file.svg
perl sort.pl > walk.csv
tail -n 7 weight.csv > recent.csv
tail -n 7 walk.csv > recentWalk.csv
gnuplot -e "datafile='weight.csv';recent='recent.csv'" newFormatWlkWt.gnu

# sug.sh: generate blood sugar chart -> sugar_plot.png
python3 split_sugar.py
gnuplot plot_split.gnuplot

# bp.sh: generate blood pressure chart -> bp_chart.png
bash bp.sh

# Build combined HTML dashboard
HTML="${SCRIPT_DIR}/dashboard.html"
cat > "$HTML" <<ENDHTML
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Health Dashboard</title>
  <style>
    body { font-family: sans-serif; background: #fff; color: #000; margin: 0; padding: 1em; }
    h2   { margin-top: 1.5em; }
    img  { width: 80%; display: block; }
  </style>
</head>
<body>
  <h2>Walk &amp; Weight</h2>
  <img src="file.svg">
  <h2>Blood Sugar</h2>
  <img src="sugar_plot.png">
  <h2>Blood Pressure</h2>
  <img src="bp_chart.png">
</body>
</html>
ENDHTML

ffx "file://${HTML}"
