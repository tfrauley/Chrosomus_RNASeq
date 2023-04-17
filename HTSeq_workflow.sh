## HTseq Count workflow (count reads)


## PRELIMINARY STEPS (only needs to be done once)

## step 1.1, make genome indexes (only needs to be done once)
cd /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results

module load samtools

for file in *.bam; do samtools index $file; done 

## step 1.2 Make directory for results
cd /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results
mkdir count_results

## step 1.3 install htseq
module load python/3.10
pip install htseq


## ANALYSIS STEP

## Step 2.1 Request interactive job for ~12 hours 32 GB RAM
srun --pty --account=rrg-emandevi -t 12:00:00 --mem 32000 /bin/bash 

## Step 2.2 load python
module load python/3.10

## Step 2.3 htseq command (*sub file paths*)
htseq-count --format bam --order pos --idattr=ID /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results/BS20-0013-eyesAligned.sortedByCoord.out.bam /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results/BS20-0013-heartAligned.sortedByCoord.out.bam /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results/BS20-0013-muscleAligned.sortedByCoord.out.bam /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results/BS20-0014-eyesAligned.sortedByCoord.out.bam /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results/BS20-0014-heartAligned.sortedByCoord.out.bam /project/rrg-emandevi/dace_rnaseq/dace_genome/alignment_results/BS20-0014-muscleAligned.sortedByCoord.out.bam /project/rrg-emandevi/communal_genomes/northernredbelly_annotation_feb2023/PO2979_Chrosomus_eos.annotation.gff.gz > /project/rrg-emandevi/dace_rnaseq/dace_genome/count_results/Ceos_countmatrix

## Step 2.4 move file to computer for DESeq2 (on local directory)
scp tfrauley@cedar.computecanada.ca:/project/rrg-emandevi/dace_rnaseq/dace_genome/count_results/Ceos_countmatrix /Users/teaghanfrauley/Desktop/Mandeville_Thesis/htseq_data