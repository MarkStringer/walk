#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  $0 DATAFILE [OUTFILE] [WINDOW] [GNUPLOTFILE]

Arguments:
  DATAFILE      Input TSV/CSV file with columns:
                date(YYYYMMDD) systolic diastolic pulse
  OUTFILE       Output image file (default: bp_chart.png)
  WINDOW        Running average window in samples (default: 5)
  GNUPLOTFILE   Gnuplot script to use (default: bp_chart.gnuplot)

This script writes a running-average file next to DATAFILE with suffix .avg
and then calls gnuplot.
USAGE
}

if [[ ${1:-} == "-h" || ${1:-} == "--help" || $# -lt 1 ]]; then
  usage
  exit $(( $# < 1 ))
fi

DATAFILE=$1
OUTFILE=${2:-bp_chart.png}
WINDOW=${3:-5}
GNUPLOTFILE=${4:-bp_chart.gnuplot}
AVGFILE="${DATAFILE}.avg"

if [[ ! -f "$DATAFILE" ]]; then
  echo "Error: data file not found: $DATAFILE" >&2
  exit 1
fi

if [[ ! "$WINDOW" =~ ^[1-9][0-9]*$ ]]; then
  echo "Error: WINDOW must be a positive integer" >&2
  exit 1
fi

if ! command -v gnuplot >/dev/null 2>&1; then
  echo "Error: gnuplot is not installed or not in PATH" >&2
  exit 1
fi

awk -v window="$WINDOW" '
BEGIN {
  FS = "[,	 ]+"
  OFS = "\t"
}
/^[[:space:]]*#/ || /^[[:space:]]*$/ { next }
NF < 4 { next }
{
  ++n
  date[n] = $1
  syst[n] = $2 + 0
  diast[n] = $3 + 0
  pulse[n] = $4 + 0

  sum_s += syst[n]
  sum_d += diast[n]
  sum_p += pulse[n]

  if (n > window) {
    sum_s -= syst[n - window]
    sum_d -= diast[n - window]
    sum_p -= pulse[n - window]
  }

  count = (n < window ? n : window)

  avg_s = sum_s / count
  avg_d = sum_d / count
  avg_p = sum_p / count

  printf "%s\t%.2f\t%.2f\t%.2f\n", date[n], avg_s, avg_d, avg_p
}
' "$DATAFILE" > "$AVGFILE"

gnuplot \
  -e "datafile='$DATAFILE'" \
  -e "avgfile='$AVGFILE'" \
  -e "outfile='$OUTFILE'" \
  -e "window=$WINDOW" \
  "$GNUPLOTFILE"

echo "Wrote running averages: $AVGFILE"
echo "Wrote chart:            $OUTFILE"
