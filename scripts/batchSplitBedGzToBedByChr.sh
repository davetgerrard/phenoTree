#!/bin/bash

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################


TOP_DIR=`pwd`
DATA_DIR="$TOP_DIR/data"
BED_DIR="$DATA_DIR/bed_files"
#OUTPUT_DIR="$TOP_DIR/output/$ANALYSIS"
SCRIPT_DIR="$TOP_DIR/scripts"

FILES=`find $BED_DIR -name '*.bed.gz'`
#FILES=`find $BED_DIR -name '*Adult_Liver*.bed.gz'`

### TO DO: parallelize this section. it takes an hour or more in series. Need separate clean up or wait for final 'rm'

for F in $FILES; do
	BASE=`basename $F '.bed.gz'`
	mkdir $BED_DIR/byChrom/$BASE
	cd $BED_DIR/byChrom/$BASE
	echo "cp $F ."
	cp $F .
	echo "gunzip $BASE.bed.gz"
	gunzip $BASE.bed.gz
	echo "bash scripts/splitBedOnChr.sh $BASE.bed"
	bash $SCRIPT_DIR/splitBedOnChr.sh $BASE.bed
	echo "rm $BASE.bed"
	rm $BASE.bed
done
