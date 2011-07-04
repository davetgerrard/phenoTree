#!/bin/bash

FILES=`find data/ -name '*.wig.gz'`

for F in $FILES; do

	bash scripts/createBwOnFiles.sh $F

done
