#!/usr/bin/env bash

samples=$(cat samples.txt)

for sample in $samples; do
	zcat ${sample}.vcf.gz | grep -v '#' | awk 'length($4)>1 || length($5)>1' > ${sample}.indel.txt
	samtools depth -a ${sample}.sorted.bam | awk '$3 < 5' | cut -f 1,2 > ${sample}.depth
	bcftools consensus -m ${sample}.depth -s ${sample} -f ../raw/covid19.fasta run772_${sample}.g.vcf.gz > ${sample}.fa
done
