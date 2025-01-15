#!/bin/bash
#how to use: ./02_trim.sh path_to_reads/ readpairs.txt adapters.tsv
mypath=$1;
adapters=$3;
readpairs=$2;
#echo "$mypath";
#cd "$mypath";
for pair in $(cat "$readpairs")
do
    echo "trimming $pair...";
    forward="$pair"".1.fq.gz";
    reverse="$pair"".2.fq.gz";
   # echo "$forward";
   # echo "$reverse";
    fwname="$(basename -s .fq.gz "$forward")""_clean.fq.gz";
    rvname="$(basename -s .fq.gz "$reverse")""_clean.fq.gz";
   # echo "$fwname";
   # echo "$rvname";
    fastq-mcf -q 30 -l 50 -k 0 -w 2 -o "02_clean/""$fwname" -o "02_clean/""$rvname" "$adapters" "$mypath""$forward" "$mypath""$reverse";
done
