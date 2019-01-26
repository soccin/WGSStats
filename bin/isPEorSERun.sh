#!/bin/bash
DIR=$1
R2FILES=$(ls $DIR/*fastq*|egrep "[\._]R2[\._]" |wc -l)
if [ "$R2FILES" -gt 0 ]; then
    echo -e $DIR"\tPE"
else
    echo -e $DIR"\tSE"
fi
