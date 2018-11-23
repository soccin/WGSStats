#!/bin/bash

#
# Usage:
#    bsub -n 2 -We 119 -o LSF/ -J SPLIT ./splitFastq.sh file.fastq.gz
#

file=$1
read=$(basename $file | perl -ne 'm/_(R[12])_/;print "$1"')
base=$(dirname $file)
samp=$(basename $base | sed 's/_IGO.*//')
project=$(echo $file | perl -ne 'm|/(Project_.*?)/|;print $1')
runid=$(basename $(echo $file | perl -pe 's|/Project_.*||'))

echo $file
echo $read, $samp

ODIR=FASTQ/$project/$runid/$samp
mkdir -p $ODIR
zcat $file | split -a 3 -d -l 16000000 - $ODIR/${samp/Sample_/}_${read}_

for file in $(find $ODIR -name "*_"$read"_*" | fgrep -v .fastq); do
    echo $file;
    mv $file ${file}.fastq
    bsub -We 119 -o LSF/ -J GZIP_$project "gzip ${file}.fastq"
done
