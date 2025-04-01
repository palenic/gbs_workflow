#!/bin/bash
# Expects a path to a folder (the one with the filtered runs) and a rea$
# Example: 03_filter/ readpairs.txt
mypath=$1;
readpairs=$2;
# echo "Checking read pairs file: $(realpath $readpairs)"

if [ ! -d "$mypath" ]; then
    echo "Directory $mypath not found.";
    exit 1;
fi
if [ ! -f "$readpairs" ]; then
    echo "File $readpairs not found.";
    exit 1;
fi


for pair in $(cat "$readpairs")
do
    cd $mypath;
    echo "Renaming $pair...";
    forward="$pair"".1_clean_fastp.1.fq.gz";
    reverse="$pair"".2_clean_fastp.2.fq.gz";
    new_forward="$pair""_clean_fastp.1.fq.gz";
    new_reverse="$pair""_clean_fastp.2.fq.gz";
    
    if [ -f "$forward" ] && [ -f "$reverse" ]; then
        mv $forward $new_forward;
        mv $reverse $new_reverse;

        echo "Files renamed successfully:";
        echo "$forward"" -> ""$new_forward";
        echo "$reverse"" -> ""$new_reverse";
    else
        echo "One or both files for $pair do not exist, skipping $pair altogether..";
    fi
done
cd ..;