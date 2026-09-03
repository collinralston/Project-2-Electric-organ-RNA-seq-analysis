#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
file1=Project2_Part3/Star_310/C_compressirostris-DNA_SRR25630310-rna_alignment-STAR_2.7.11b-Aligned.out.sam
file2=Project2_Part3/Star_391/C_compressirostris-DNA_SRR25630391-rna_alignment-STAR_2.7.11b-Aligned.out.sam
/usr/bin/time -v Project2_Part3/PS8-mapped.py -f $file1
/usr/bin/time -v Project2_Part3/PS8-mapped.py -f $file2