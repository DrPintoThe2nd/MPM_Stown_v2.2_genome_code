#!bin/bash

#usage "bash minimap2_mapping.sh genome.fasta"

#gather samples names from the working directory
ls *_R1.fastq.gz > samples.txt
sed -i "s/_R1.fastq.gz//g" samples.txt

#map reads
cat samples.txt | while read line 
do
echo "mapping them reads, king ;)"
minimap2 -ax sr $1 $line\_R1_dedupe.fastq.gz $line\_R2_dedupe.fastq.gz -t24 | samtools sort -@ 6 - | samtools view -@ 6 -Sb - > bams/$line\.bam 2>/dev/null 
done

#index bams
cat samples.txt | while read line 
do
echo "indexing bam files, king ;)"
samtools index bams/$line\.bam
done

