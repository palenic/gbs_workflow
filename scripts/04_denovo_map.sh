#!/bin/bash
# Expects a path to a folder (the one with the filtered, renamed runs) and a populations.txt file
# Example: 03_filter/ populations.txt
mypath=$1;
populations=$2;

mkdir -p 04_denovo; # creates the 04_denovo folder if not already created

denovo_map.pl --samples "$mypath" --popmap ./"$populations" --out-path 04_denovo/ --paired -m 3 -M 2 -n 1 -X "ustacks: --force-diff-len" -X "populations: --vcf" --threads 20 --min-samples-per-pop 0.80;

