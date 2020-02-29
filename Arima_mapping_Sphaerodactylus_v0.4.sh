#! /bin/bash

##############################################
# ARIMA GENOMICS MAPPING PIPELINE 02/08/2019 # modified by B.J.P. 02/2020
##############################################

#Below find the commands used to map HiC data.

#Replace the variables at the top with the correct paths for the locations of files/programs on your system.

#This bash script will map one paired end HiC dataset (read1 & read2 fastqs). Feel to modify and multiplex as you see fit to work with your volume of samples and system.

#git clone https://github.com/ArimaGenomics/mapping_pipeline.git;
#mv mapping_pipeline Sphaerodactylus_mapping_pipeline;
#cd Sphaerodactylus_mapping_pipeline;

##########################################
# Commands #
##########################################

SRA='S_townsendi_HiC_TG3718'
LABEL='S_townsendi_mapping_v0.4'
IN_DIR='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/'
REF='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/S_townsendi_TG3544_v0.4_FINAL_ARCS'
FAIDX='$REF.fai'
RAW_DIR='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/raw_v0.4'
FILT_DIR='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/filtered_v0.4'
FILTER='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/filter_five_end.pl'
COMBINER='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/two_read_bam_combiner.pl'
STATS='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/get_stats.pl'
TMP_DIR='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/temp_v0.4'
PAIR_DIR='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/pair_v0.4'
REP_DIR='/media/bjp/SSD/2020_NEW_working_dir/Sphaerodactylus_mapping_pipeline/remove_dups_v0.4'
MAPQ_FILTER=10
CPU=42

echo "### Step 0: Check output directories exist & create them as needed"
[ -d $RAW_DIR ] || mkdir -p $RAW_DIR
[ -d $FILT_DIR ] || mkdir -p $FILT_DIR
[ -d $TMP_DIR ] || mkdir -p $TMP_DIR
[ -d $PAIR_DIR ] || mkdir -p $PAIR_DIR
[ -d $REP_DIR ] || mkdir -p $REP_DIR

echo "### Step 0: Index reference" # Run only once! Skip this step if you have already generated BWA index files
bwa index $REF

echo "### Step 1.A: FASTQ to BAM (1st)"
bwa mem -t $CPU $REF $IN_DIR/$SRA\_1.fastq.gz | samtools view -@ $CPU -Sb - > $RAW_DIR/$SRA\_1.bam

echo "### Step 1.B: FASTQ to BAM (2nd)"
bwa mem -t $CPU $REF $IN_DIR/$SRA\_2.fastq.gz | samtools view -@ $CPU -Sb - > $RAW_DIR/$SRA\_2.bam

echo "### Step 2.A: Filter 5' end (1st)"
samtools view -h $RAW_DIR/$SRA\_1.bam | perl $FILTER | samtools view -Sb - > $FILT_DIR/$SRA\_1.bam

echo "### Step 2.B: Filter 5' end (2nd)"
samtools view -h $RAW_DIR/$SRA\_2.bam | perl $FILTER | samtools view -Sb - > $FILT_DIR/$SRA\_2.bam

echo "### Step 3.A: Pair reads & mapping quality filter"
perl $COMBINER $FILT_DIR/$SRA\_1.bam $FILT_DIR/$SRA\_2.bam samtools $MAPQ_FILTER | samtools view -bS -t $FAIDX - | samtools sort -@ $CPU -o $TMP_DIR/$SRA.bam -

echo "### Step 3.B: Add read group"
picard AddOrReplaceReadGroups INPUT=$TMP_DIR/$SRA.bam OUTPUT=$PAIR_DIR/$SRA.bam ID=$SRA LB=$SRA SM=$LABEL PL=ILLUMINA PU=none

echo "### Step 4: Mark duplicates"
picard MarkDuplicates INPUT=$PAIR_DIR/$SRA.bam \
	OUTPUT=$REP_DIR/$SRA.bam \
	METRICS_FILE=$REP_DIR/metrics.$SRA.txt \
	ASSUME_SORTED=TRUE \
	VALIDATION_STRINGENCY=LENIENT \
	REMOVE_DUPLICATES=TRUE

samtools index $REP_DIR/$SRA.bam

perl $STATS $REP_DIR/$SRA.bam > $REP_DIR/$SRA.bam.stats

echo "Finished Mapping Pipeline through Duplicate Removal"

