#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
fasta=/projects/bgmp/shared/Bi623/Project2/campylomormyrus.fasta
gff=/projects/bgmp/shared/Bi623/Project2/campylomormyrus.gff
/usr/bin/time -v pixi run STAR --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir Project2_Part3/C_compressirostris.dna.primary_assembly.STAR_2.7.11b \
    --genomeFastaFiles $fasta \
    --sjdbGTFfile Project2_Part3/campylomormyrus.gtf