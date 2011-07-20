#!/bin/bash

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################

F=$1
TOP_DIR=`pwd`
DATA_DIR="$TOP_DIR/data"
ANALYSIS="coverageBedByChrom"
OUTPUT_DIR="$TOP_DIR/output/$ANALYSIS"
SCRIPT_DIR="$TOP_DIR/scripts"


# check if output directory exists and make if not. 
if [ ! -d "$OUTPUT_DIR" ]; then
        mkdir $OUTPUT_DIR
fi

#for Q in $Q_LIST; do
#done

BASE=`basename $F '.bed'`
#
#QSUB_PARAMS='-V -b y -cwd -q slow.q '
# do bin counts in a file specific directory.
#qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/GetBinsFromBed.pl $DATA_DIR/chr11.1000.bed $BW_DIR/$BASE/$BASE.bw $BASE.chr11.1000.bed.counts
#qsub $QSUB_PARAMS -N coverageBedByChrom coverageBed -a $F -b data/genome_table.hg19.bed > $OUTPUT_DIR/$BASE.coverageBed
coverageBed -a $F -b data/genome_table.hg19.bed > $OUTPUT_DIR/$BASE.coverageBed
#cd ..
