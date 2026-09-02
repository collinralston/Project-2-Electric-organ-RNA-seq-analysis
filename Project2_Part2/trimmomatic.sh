#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
/usr/bin/time -v pixi run trimmomatic PE \
Project2_Part2/cutadapt_outs/SRR25630310_1_adapted.fastq \
Project2_Part2/cutadapt_outs/SRR25630310_2_adapted.fastq \
Project2_Part2/trimmomatic_outs/SRR25630310_1_paired.fastq \
Project2_Part2/trimmomatic_outs/SRR25630310_1_unpaired.fastq \
Project2_Part2/trimmomatic_outs/SRR25630310_2_paired.fastq \
Project2_Part2/trimmomatic_outs/SRR25630310_2_unpaired.fastq \
SLIDINGWINDOW:5:15 \
LEADING:3 \
TRAILING:3 \
MINLEN:35

/usr/bin/time -v pixi run trimmomatic PE \
Project2_Part2/cutadapt_outs/SRR25630391_1_adapted.fastq \
Project2_Part2/cutadapt_outs/SRR25630391_2_adapted.fastq \
Project2_Part2/trimmomatic_outs/SRR25630391_1_paired.fastq \
Project2_Part2/trimmomatic_outs/SRR25630391_1_unpaired.fastq \
Project2_Part2/trimmomatic_outs/SRR25630391_2_paired.fastq \
Project2_Part2/trimmomatic_outs/SRR25630391_2_unpaired.fastq \
SLIDINGWINDOW:5:15 \
LEADING:3 \
TRAILING:3 \
MINLEN:35