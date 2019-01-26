#!/bin/bash
export MAPBIN=/home/socci/Code/Inventory/mkMapFiles/HiSeq
SDIR="$( cd "$( dirname "$0" )" && pwd )"
SAMPLEDIRS=$1
cat $SAMPLEDIRS | xargs -n 1 $SDIR/isPEorSERun.sh >sampleManifest
$MAPBIN/cvtManifest2Mapfile.py sampleManifest
rm sampleManifest
