#!/bin/bash
#how to use:
# demultiplex.sh read1.fq.gz read2.fq.gz barcodes.tsv
read1=$1;
read2=$2;
barcode_file=$3;
process_radtags -1 "$read1" -2 "$read2" -o ./01_demulti/ -b "$barcode_file" -e apeKI -r --threads 4 -y 'gzfastq';
cd 01_demulti
if [ ! -d unpaired_reads ]; then
    mkdir unpaired_reads;
fi
mv *rem* unpaired_reads/;
