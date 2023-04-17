## STAR Workflow (Align Reads)


## PRELIMINARY STEPS/GENOME INDEX (only needs to be done once)

## Step 1: directory/file prep
##1.1 change directories
cd /project/rrg-emandevi/dace_rnaseq

##1.2 make new directory for results
makedir /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results

## 1.3 unzip fastq files
for file in *.fastq.gz; do gunzip $file; done

## Step 2: Index Genome
##2.1: Request interactive job for 6 hours 32 GB RAM*
srun --pty --account=rrg-emandevi -t 6:00:00 --mem 32000 /bin/bash

##2.3: Load the STAR software as a module
module load star

##2.4: Index Genome 
STAR --runThreadN 8 --runMode genomeGenerate --genomeDir dace_genome --genomeFastaFiles dace_genome/Ceos_june2021.fasta


## ANALYSIS STEP (Do for each sample)
## 3.1: Request interactive job for 6 hours 32 GB RAM*
srun --pty --account=rrg-emandevi -t 6:00:00 --mem 32000 /bin/bash

## 3.2: Load STAR
module load star

## 3.3: align file (*sub file paths*)
STAR --runThreadN 12 --runMode alignReads --genomeDir dace_genome/alignment_results --readFilesIn /project/rrg-emandevi/dace_rnaseq/BS20-0013-muscle_R1_001.fastq /project/rrg-emandevi/dace_rnaseq/BS20-0013-muscle_R2_001.fastq --outFileNamePrefix dace_genome/alignment_results/BS20-0013-muscle --outSAMtype BAM SortedByCoordinate


