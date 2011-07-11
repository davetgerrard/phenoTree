#!/bin/bash

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################

FILES=`find data/bed_files -name '*.bed.gz'`
#FILES=`find data/bed_files -name '*Adult_Liver*.bed.gz'`

COUNT=0
for F in $FILES; do
	JOB_COUNT="JOB".$COUNT 
	QSUB_PARAMS='-V -b y -cwd -q node.q '
	# do bin counts in a file specific directory.
	#echo "qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/GetBinsFromBed.pl $DATA_DIR/chr11.1000.bed $BW_DIR/$BASE.bw $BASE.chr11.1000.bed.counts"
	#qsub $QSUB_PARAMS -N $BASE perl $SCRIPT_DIR/GetBinsFromBed.pl $DATA_DIR/chr11.1000.bed $BW_DIR/$BASE/$BASE.bw $BASE.chr11.1000.bed.counts
	
	qsub $QSUB_PARAMS -N $JOB_COUNT bash scripts/catChromFilesInDir.sh $F
	COUNT=`expr $COUNT + 1` ;
done
