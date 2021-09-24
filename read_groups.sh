#!bin/bash

#ls *.bam > samples.txt
#sed -i "s/.bam//g" samples.txt


cat samples.txt | while read line 
do

picard AddOrReplaceReadGroups \
	I=$line\.bam \
	O=$line\_RG.bam \
	RGID=$line \
	RGLB=lib1 \
	RGPL=ILLUMINA \
	RGPU=unit1 \
	RGSM=$line;
picard FixMateInformation \
	I=$line\_RG.bam \
	O=$line\_genome.bam \
	ADD_MATE_CIGAR=true;

rm ./*_RG.bam

sambamba -p -t12 $line\_genome.bam

done
