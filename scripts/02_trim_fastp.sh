#!/bin/bash
# How to use: ./02_trim_fastp.sh path_to_reads/ readpairs.txt adapters.txt
mypath=$1;
adapters=$3;
readpairs=$2;
echo "$mypath";
#cd "$mypath";
for pair in $(cat "$readpairs")
do
    echo "";
    echo "Trimming $pair...";
    forward="$pair"".1.fq.gz";
    reverse="$pair"".2.fq.gz";
    # echo "$forward";
    # echo "$reverse";
    fwname="$(basename -s .fq.gz "$forward")""_clean.fq.gz";
    rvname="$(basename -s .fq.gz "$reverse")""_clean.fq.gz";
    # echo "$fwname";
    # echo "$rvname";
    fastp --in1 "$mypath""$forward" --in2 "$mypath""$reverse" --out1 "02_clean_fastp/""$fwname" --out2 "02_clean_fastp/""$rvname" --thread 16 --dont_eval_duplication --length_required 50 --trim_poly_g --poly_g_min_len 5 --cut_tail --cut_tail_window_size 2 --cut_tail_mean_quality 30 --cut_front --cut_front_window_size 2 --cut_front_mean_quality 30 --adapter_fasta "$adapters";
    echo "Finished ""$pair"".";
done
