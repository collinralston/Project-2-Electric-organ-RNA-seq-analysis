#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00

#Create genome database
fasta=/projects/bgmp/shared/Bi623/Project2/campylomormyrus.fasta
gff=/projects/bgmp/shared/Bi623/Project2/campylomormyrus.gff
/usr/bin/time -v pixi run STAR --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir Project2_Part3/C_compressirostris.dna.primary_assembly.STAR_2.7.11b \
    --genomeFastaFiles $fasta \
    --sjdbGTFfile Project2_Part3/campylomormyrus.gtf

#Genome Alignment
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
--outFileNamePrefix Project2_Part3/Star_391/C_compressirostris-DNA_SRR25630391-rna_alignment-STAR_2.7.11b-

/usr/bin/time -v pixi run STAR --runThreadN 8 --runMode alignReads \
--outFilterMultimapNmax 3 \
--outSAMunmapped Within KeepPairs \
--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
--readFilesCommand zcat \
--readFilesIn $in1 $in2 \
--genomeDir Project2_Part3/C_compressirostris.dna.primary_assembly.STAR_2.7.11b \
--outFileNamePrefix Project2_Part3/Star_310/C_compressirostris-DNA_SRR25630310-rna_alignment-STAR_2.7.11b-

#output mapped and unmapped reads
file1=Project2_Part3/Star_310/C_compressirostris-DNA_SRR25630310-rna_alignment-STAR_2.7.11b-Aligned.out.sam
file2=Project2_Part3/Star_391/C_compressirostris-DNA_SRR25630391-rna_alignment-STAR_2.7.11b-Aligned.out.sam
/usr/bin/time -v Project2_Part3/PS8-mapped.py -f $file1
/usr/bin/time -v Project2_Part3/PS8-mapped.py -f $file2

#run htseq-count
sam1=Project2_Part3/Star_310/C_compressirostris-DNA_SRR25630310-rna_alignment-STAR_2.7.11b-Aligned.out.sam
sam2=Project2_Part3/Star_391/C_compressirostris-DNA_SRR25630391-rna_alignment-STAR_2.7.11b-Aligned.out.sam
gtf=Project2_Part3/campylomormyrus.gtf
/usr/bin/time -v pixi run htseq-count -i gene_id -s yes $sam1 $gtf > HTseq_out.txt
/usr/bin/time -v pixi run htseq-count -i gene_id -s yes $sam2 $gtf >> HTseq_out.txt
/usr/bin/time -v pixi run htseq-count -i gene_id -s reverse $sam1 $gtf >> HTseq_out.txt
/usr/bin/time -v pixi run htseq-count -i gene_id -s reverse $sam2 $gtf >> HTseq_out.txt

#extract all the /usr/bin/time outputs
cat HTseq_out.txt | grep "^\s" > HTSeq_times.txt

#organize the htseq output into 4 different files
./Project2_Part3/organize_slurm_htseq.py

#check the counts of the fwd and rvs strands
cat SRR25630310_strnd |grep -v "^__" | cut -f 2 |  awk '{sum+=$1} END {print sum}'
cat SRR25630310_rvs_strnd |grep -v "^__" | cut -f 2 |  awk '{sum+=$1} END {print sum}'
cat SRR25630391_strnd |grep -v "^__" | cut -f 2 |  awk '{sum+=$1} END {print sum}'
cat SRR25630391_rvs_strnd |grep -v "^__" | cut -f 2 |  awk '{sum+=$1} END {print sum}'

