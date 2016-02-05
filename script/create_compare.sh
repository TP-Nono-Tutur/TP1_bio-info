#!/bin/bash
FILE1=$1
FILE_DEBUT=$(echo $FILE1 | sed 's/\..*//')

j=10
for i in $(seq 0 3)
do
    FILE="$FILE_DEBUT-mutant-$j.fasta"
    ./bioseq.native  random-mutations $j $FILE1 > $FILE
    j=$(($j * 10))
    ./script/compare.sh $FILE1 $FILE
    rm $FILE
done
