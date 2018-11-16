#!/bin/bash

PROJNO=$(ls *_sample_mapping.txt | sed s'/_sample_mapping.txt//')
ODIR=${PROJNO}_QC
mkdir $ODIR
cp out___/*.txt out___/*.pdf $ODIR
rm -rf FASTQ LSF* _scratch out___/*.ba? &
zip -r ${ODIR}.zip $ODIR
