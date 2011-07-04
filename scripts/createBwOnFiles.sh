#!/bin/bash


F=$1
#START_DIR=`pwd`
TOP_DIR=`pwd`
DATA_DIR="$TOP_DIR/data"
#ANALYSIS="binCounts"
OUTPUT_DIR="$DATA_DIR/bigwig_files"
SCRIPT_DIR="$TOP_DIR/scripts"

#for Q in $Q_LIST; do


BASE=`basename $F '.wig.gz'`

# check the filename is appropriate for a directory name

# make a directory for this file's operations
echo "mkdir $OUTPUT_DIR/$BASE"
mkdir $OUTPUT_DIR/$BASE
# copy the file to a file specific directory
echo "cp $DATA_DIR/$BASE.wig.gz $OUTPUT_DIR/$BASE/"
cp $DATA_DIR/$BASE.wig.gz $OUTPUT_DIR/$BASE/
# cd to that directory
echo "cd $OUTPUT_DIR/$BASE/"
cd $OUTPUT_DIR/$BASE/
# gunzip the copied file
echo "gunzip $BASE.wig.gz  "
gunzip $BASE.wig.gz
# remove the track line NO, this seems to cock things up.
#perl -pi -e '$_ = "" if ($. == 1);' $BASE.wig

# convert to bigwig
echo "wigToBigWig $BASE.wig $DATA_DIR/genome_table.hg19 $BASE.bw"
wigToBigWig $BASE.wig $DATA_DIR/genome_table.hg19 $BASE.bw
# delete the copied file
echo "rm $BASE.wig"
rm $BASE.wig

#
#done
