#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
/usr/bin/time -v pixi run cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o SRR25630391_1_adapted.fastq -p SRR25630391_2_adapted.fastq SRR25630391_1.fastq SRR25630391_2.fastq
