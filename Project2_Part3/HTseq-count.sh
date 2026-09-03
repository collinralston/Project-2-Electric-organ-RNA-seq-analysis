#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
sam1=Project2_Part3/Star_310/C_compressirostris-DNA_SRR25630310-rna_alignment-STAR_2.7.11b-Aligned.out.sam
sam2=Project2_Part3/Star_391/C_compressirostris-DNA_SRR25630391-rna_alignment-STAR_2.7.11b-Aligned.out.sam
gtf=Project2_Part3/campylomormyrus.gtf
/usr/bin/time -v pixi run htseq-count -i gene_id -s yes $sam1 $gtf
/usr/bin/time -v pixi run htseq-count -i gene_id -s yes $sam2 $gtf
/usr/bin/time -v pixi run htseq-count -i gene_id -s reverse $sam1 $gtf
/usr/bin/time -v pixi run htseq-count -i gene_id -s reverse $sam2 $gtf