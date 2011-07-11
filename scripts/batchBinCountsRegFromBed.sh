#!/bin/bash

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################

FILES=`find data/bed_files -name '*.bed.gz'`
#FILES=`find data/bed_files -name '*Adult_Liver*.bed.gz'`

for F in $FILES; do

	bash scripts/binCountRegFromBed.sh $F

done
