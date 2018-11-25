#!/bin/bash

MAP=$1

cat $MAP | cut -f 4 | sed 's/.Sample_.*//' | sort | uniq \
    | xargs bsub -app anyOS -R "select[type==CentOS7]" -W 96:00 -n 1 -J CTRL -o LSF.CTRL/ ./WGSStats/doWGSStats.sh
