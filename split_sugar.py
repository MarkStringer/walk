#!/usr/bin/env python3
import csv

input_file = "sugar.csv"
fasting_file = "fasting.csv"
postpradial_file = "postprandial.csv"

with open(input_file, newline="") as infile, \
     open(fasting_file, "w", newline="") as fasting_out, \
     open(postpradial_file, "w", newline="") as post_out:

    reader = csv.reader(infile, delimiter="\t")
    fasting_writer = csv.writer(fasting_out, delimiter="\t")
    post_writer = csv.writer(post_out, delimiter="\t")

    for row in reader:
        if len(row) < 3:
            continue

        tag = row[2].strip()
        if not tag:
            continue

        first = tag[0].lower()
        if first == "f":
            fasting_writer.writerow(row)
        elif first == "p":
            post_writer.writerow(row)
