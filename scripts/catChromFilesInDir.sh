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


BASE=`basename $F '.bed.gz'`





#echo "cd $OUTPUT_DIR/$BASE/"
#cd $OUTPUT_DIR/$BASE/

cat `find $OUTPUT_DIR/$BASE -name '*.1000.binCounts'` >  $OUTPUT_DIR/$BASE.1000.binCounts   # concatenate output files. Note backticks.
bedSort $OUTPUT_DIR/$BASE.1000.binCounts $OUTPUT_DIR/$BASE.1000.binCounts



