#!/bin/bash

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################

F=$1
#START_DIR=`pwd`
TOP_DIR=`pwd`
DATA_DIR="$TOP_DIR/data"
BED_DIR="$DATA_DIR/bed_files"
ANALYSIS="binCounts"
OUTPUT_DIR="$TOP_DIR/output/$ANALYSIS"
SCRIPT_DIR="$TOP_DIR/scripts"
BIN_SIZE=1000
GENOME_TABLE="$DATA_DIR/genome_table.hg19"

#for Q in $Q_LIST; do


BASE=`basename $F '.bed.gz'`

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
#echo "qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/GetBinsFromBed.pl $DATA_DIR/chr11.1000.bed $BW_DIR/$BASE.bw $BASE.chr11.1000.bed.counts"
#qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/GetBinsFromBed.pl $DATA_DIR/chr11.1000.bed $BW_DIR/$BASE/$BASE.bw $BASE.chr11.1000.bed.counts
# archetype: perl ../scripts/countBedToRegBins.pl GSM669624_UCSF-UBC.Fetal_Brain.H3K4me3.HuFNSC-T.chr11.bed ../data/genome_table.hg19 1000 testBinning11.out

CHR_BED_FILES=`find $BED_DIR -name $BASE.chr*.bed`

for CHR_F in $CHR_BED_FILES; do
	CHR_F_BASE=`basename $CHR_F '.bed'`
	echo "qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/countBedToRegBins.pl $CHR_F $GENOME_TABLE $BIN_SIZE $CHR_F_BASE.$BIN_SIZE.binCounts"

done
