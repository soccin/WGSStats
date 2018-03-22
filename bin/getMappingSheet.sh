#!/bin/bash
export MAPBIN=/home/socci/Code/Inventory/mkMapFiles/HiSeq
SAMPLEDIRS=$1
cat $SAMPLEDIRS | xargs -n 1 $MAPBIN/isPEorSERun.sh >sampleManifest 
$MAPBIN/cvtManifest2Mapfile.py sampleManifest 
#rm sampleManifest
