#!/bin/bash

FILES=`find data/ -name '*.wig.gz'`

for F in $FILES; do

	bash scripts/binCountOnFileBase.sh $F

done
