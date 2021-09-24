#!bin/bash

ls *_RG.bam > samples.txt
sed -i "s/_RG.bam//g" samples.txt

cat samples.txt | while read line 
do
echo "indexing bam files"
sambamba index $line\_RG.bam 2>/dev/null
done

cat samples.txt | while read line 
do
echo "calculating read depth"
MOSDEPTH_PRECISION=5 mosdepth -x -n -t4 -Q 3 -b 500000 $line $line\_RG.bam
done
