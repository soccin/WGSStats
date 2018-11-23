#!/bin/bash

# bsub -n 1 -q control -J CTRL

SDIR="$( cd "$( dirname "$0" )" && pwd )"

if [ "$#" -lt "1" ]; then
    echo
    echo "   usage: WGSStats/doWGSStats.sh [-g GENOME] PROJECTDIR"
    echo
    echo "      human_b37"
    echo "      mouse_mm10"
    echo
    exit
fi

GENOME=human_b37

while getopts "g:" opt; do
    case "$opt" in
        g)
            GENOME=$OPTARG
            ;;
    esac
done

shift $((OPTIND-1))

echo GENOME=$GENOME

PROJECTDIR=$1
project=$(echo $PROJECTDIR | perl -ne 'm|/(Project_[^/]*)|;print $1')
echo project=$project

find $* -type f | fgrep .fastq.gz | xargs -n 1 bsub -We 119 -n 2 -o LSF/ -J SPLIT_$$ $SDIR/splitFastq.sh

echo
$SDIR/bin/bSync SPLIT_$$
sleep 15
echo bSync GZIP_$project
$SDIR/bin/bSync GZIP_$project

ls -1d $PWD/FASTQ/$project/*/S* | fgrep $project >sampleDIRs_$$
mappingSheet=${project/Project/Proj}_sample_mapping.txt
$SDIR/bin/getMappingSheet.sh sampleDIRs_$$ >$mappingSheet
sleep 15

$SDIR/PEMapper/runPEMapperMultiDirectories.sh $GENOME $mappingSheet

