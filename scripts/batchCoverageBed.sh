#!/bin/bash

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################

FILES=`find data/bed_files -name '*.bed.gz'`

TEMP_DIR='temp'

# CHECK IF TEMP_DIR EXISTS
if [ ! -d "$TEMP_DIR" ]; then
	mkdir $TEMP_DIR
fi	

for F in $FILES; do
	cp $F temp/
	BASE=`basename $F '.bed.gz'`
	gunzip temp/$BASE.bed.gz
	#bash scripts/binCountOnFileBase.sh $F
	qsub -V -b y -cwd -q slow.q -N bedCoverageTest bash scripts/runCoverageBed.sh temp/$BASE.bed
	#rm temp/$BASE.bed"
done

qsub -V -b y -cwd -q slow.q -hold_jid bedCoverageTest -N cleanUp rm temp/*.bed
