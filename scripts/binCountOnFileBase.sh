#!/bin/bash


F=$1
#START_DIR=`pwd`
TOP_DIR=`pwd`
DATA_DIR="$TOP_DIR/data"
BW_DIR="$DATA_DIR/bigwig_files"
ANALYSIS="binCounts"
OUTPUT_DIR="$TOP_DIR/output/$ANALYSIS"
SCRIPT_DIR="$TOP_DIR/scripts"

#for Q in $Q_LIST; do


BASE=`basename $F '.wig.gz'`

# check the filename is appropriate for a directory name

# make a directory for this file's operations
#echo "mkdir $OUTPUT_DIR/$BASE"
#mkdir $OUTPUT_DIR/$BASE
# cd to that directory
echo "cd $OUTPUT_DIR/$BASE/"
cd $OUTPUT_DIR/$BASE/


#
QSUB_PARAMS='-V -b y -cwd -q node.q '
# do bin counts in a file specific directory.
echo "qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/GetBinsFromBed.pl $DATA_DIR/chr11.1000.bed $BW_DIR/$BASE.bw $BASE.chr11.1000.bed.counts"
qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/GetBinsFromBed.pl $DATA_DIR/chr11.1000.bed $BW_DIR/$BASE/$BASE.bw $BASE.chr11.1000.bed.counts
#cd ..
#done
