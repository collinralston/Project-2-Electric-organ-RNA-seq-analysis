#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
in1=Project2_Part2/trimmomatic_outs/SRR25630310_1_paired.fastq.gz
in2=Project2_Part2/trimmomatic_outs/SRR25630310_2_paired.fastq.gz
in3=Project2_Part2/trimmomatic_outs/SRR25630391_1_paired.fastq.gz
in4=Project2_Part2/trimmomatic_outs/SRR25630391_2_paired.fastq.gz
/usr/bin/time -v pixi run STAR --runThreadN 8 --runMode alignReads \
--outFilterMultimapNmax 3 \
--outSAMunmapped Within KeepPairs \
--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
--readFilesCommand zcat \
--readFilesIn $in3 $in4 \
--genomeDir Project2_Part3/C_compressirostris.dna.primary_assembly.STAR_2.7.11b \
--outFileNamePrefix C_compressirostris-DNA_SRR25630391-rna_alignment-STAR_2.7.11b-

/usr/bin/time -v pixi run STAR --runThreadN 8 --runMode alignReads \
--outFilterMultimapNmax 3 \
--outSAMunmapped Within KeepPairs \
--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
--readFilesCommand zcat \
--readFilesIn $in1 $in2 \
--genomeDir Project2_Part3/C_compressirostris.dna.primary_assembly.STAR_2.7.11b \
--outFileNamePrefix C_compressirostris-DNA_SRR25630310-rna_alignment-STAR_2.7.11b-