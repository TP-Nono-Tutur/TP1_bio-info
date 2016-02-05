#!/bin/bash
FILE1=$1
FILE2=$2
echo "comparaison de $FILE1 et $FILE2"
for i in $(seq 4 4 20)
do
    echo "$i $(./bioseq.native ratio-common-kmers $i $FILE1 $FILE2)"
done
