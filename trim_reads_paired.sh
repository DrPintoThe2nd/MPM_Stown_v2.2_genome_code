#!bin/bash

#This script simply takes paired-end Ilumina reads and runs trim_galore on every pair in a samples list
#Made by Brendan J. Pinto on 9/1/2020

#gather samples names from the working directory
ls *_R1.fastq.gz > samples.txt
sed -i "s/_R1.fastq.gz//g" samples.txt

cat samples.txt | while read line 
do
echo "trimming *_R1/2.fastq.gz.."
trim_galore --cores 12 --paired $line\_R1.fastq.gz $line\_R2.fastq.gz 2>/dev/null 
done

