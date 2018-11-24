#!/bin/bash

MAP=$1

cat $MAP | cut -f 4 | sed 's/.Sample_.*//' | sort | uniq \
    | xargs bsub -n 1 -q control -J CTRL -o LSF.CTRL/ ./WGSStats/doWGSStats.sh
