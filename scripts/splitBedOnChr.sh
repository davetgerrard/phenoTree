#!/bin/bash

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################

F=$1
#TOP_DIR=`pwd`
#DATA_DIR="$TOP_DIR/data"
#OUTPUT_DIR="$TOP_DIR/output/$ANALYSIS"
#SCRIPT_DIR="$TOP_DIR/scripts"


# take a bed file and split by chromosome into separate bed files.

# archetype: awk '{print $0 >> $1".bed"}' example.bed
BASE=`basename $F '.bed'`
awk -v base=$BASE '{print $0 >> base"."$1".bed"}' $F

# sort each resulting file.
# need list of new files
IND_FILES=`find . -name '*.chr*.bed'`

echo "$IND_FILES"



## sort the files. Required when original file not sorted e.g. when + and - reads are separated.

for THIS_F in $IND_FILES; do
	bedSort $THIS_F $THIS_F
done

# remove individual chr files?

#rm $BASE.chr* 




## utilites

#for Q in $Q_LIST; do
#done

#BASE=`basename $F '.wig.gz'`
#
QSUB_PARAMS='-V -b y -cwd -q node.q '
# do bin counts in a file specific directory.
#qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/GetBinsFromBed.pl $DATA_DIR/chr11.1000.bed $BW_DIR/$BASE/$BASE.bw $BASE.chr11.1000.bed.counts
#cd ..
