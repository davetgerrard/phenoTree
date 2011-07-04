#!/bin/bash

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################

FILES=`find data/ -name '*.wig.gz'`

for F in $FILES; do

	bash scripts/binCountOnFileBase.sh $F

done
