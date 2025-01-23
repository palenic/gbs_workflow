#!/bin/bash
# expects a path in the form a/b/c/folder_with_files/
mypath=$1;
readpairs=$2;
myfolder="$(echo $mypath | rev | cut -d "/" -f 2 | rev)";
#echo $myfolder;
for pair in $(cat "$readpairs")
do
    echo "filtering $pair...";
    forward="$pair"".1_clean.fq.gz";
    reverse="$pair"".2_clean.fq.gz";
  #  echo "$forward";
  #  echo "$reverse";
    process_radtags -1 "$mypath""$forward" -2 "$mypath""$reverse" -o ./03_filter/ -e apeKI -r -c -q \
      --adapter-1 AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG \
      --adapter-2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT --threads 20;
    cd 03_filter;
    mv "process_radtags.log" "process_radtags.""$pair"".log";
    cd ../;
#    echo "process_radtags.""$myfolder"".log";
done
cd 03_filter;
if [ ! -d unpaired_reads ]; then
    mkdir unpaired_reads;
fi
if [ ! -d logs ]; then
    mkdir logs;
fi
mv *rem* unpaired_reads/;
for pair in $(cat "../""$readpairs")
do
    touch "summary_""$pair";
    echo "$pair" > "summary_""$pair";
    stacks-dist-extract "process_radtags.""$pair"".log" total_raw_read_counts | cut -f 1,3 --complement >> "summary_""$pair";
done
mv process_radtags* logs/;
mv summary_* logs/;
paste logs/summary_* > summary_total.txt;
#Rscript --no-init-file -e 'write.table(t(read.table("summary_total.txt")),"summary_transp.tsv",quote=F,col.names=F,row.names=F)'>/dev/null;
#mv summary_total.txt logs/;
cd ..;

