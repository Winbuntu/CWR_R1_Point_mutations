# Detect point mutations in CWR-R1 mouse model cfDNA sequencing data

path: /labshares/fanlab/anqin/cfDNA_project/CWR\_R1\_Point\_mutations

data: 16C-1

##Fetch TP53 point mutation, visualize in IGV
1. Search hg38 reference, get TP53 interval

```
samtools view -b 16C-1_S101_L008_R1_001.fastq.gz_bwa_align_sorted_gpied_dedup_realign.bam  "chr17:7,668,402-7,687,538" > TP53.bam
samtools index TP53.bam
```

2. Visualize **TP53.bam** and **TP53.bam.bai** using IGV

	This is the TP53 point mutation position chr17:7,673,536

```
samtools view -b 16C-1_S101_L008_R1_001.fastq.gz_bwa_align_sorted_gpied_dedup_realign.bam  "chr17:7,673,536-7,673,537" > TP53_one_point.bam
samtools index TP53_one_point.bam
```


##Call mutations on X chromosome, compare against reference paper

[AR intragenic deletions linked to androgen receptor splice variant expression and activity in models of prostate cancer progression](http://www.nature.com/onc/journal/v31/n45/full/onc2011637a.html)
Supplementary table contatins point mutations identified by trageted genome sequencing.

1. Download human reference genome hg19