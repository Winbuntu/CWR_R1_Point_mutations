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

## Visualize AR gene

```
samtools view -b 16C-1_S101_L008_R1_001.fastq.gz_bwa_align_sorted_gpied_dedup_realign.bam  "chrX:67,544,623-67,730,619" > AR.bam
samtools index AR.bam
# per base coverage
samtools depth -r chrX:67,544,623-67,730,619 AR.bam > AR_perbase_cov.txt

```
It is difficult to identify breakpoint manully. 

Try use Delly2 to identify breakpoint first. Here is the code to run delly DEL calling on AR region.

```
sh ./delly2_code.sh AR_region AR.bam
```
The result is not very good. Although I can detect a deletion, but it is not at the correct positon.

Draw coverage plot using **AR\_cov.R**

Conclusion: Dominant subpopulation can change depends on culture condition.

##Call mutations on X chromosome, compare against reference paper

[AR intragenic deletions linked to androgen receptor splice variant expression and activity in models of prostate cancer progression](http://www.nature.com/onc/journal/v31/n45/full/onc2011637a.html)
Supplementary table contatins point mutations identified by trageted genome sequencing.

1. Download human reference genome hg19
2. Re-align reads using hg19. (**Map\_and\_call\_hg19.sh**)

```
bgrun -m a -n CWR_hg19 "sh ./Map_and_call_hg19.sh 16C-1_S101_L008_R1_001.fastq.gz 16C-1_S101_L008_R2_001.fastq.gz 256"
	
```

3. Use heplotype caller to identify mutations on AR region.
	```
	bgrun -m a -n CallCWR_AR "sh ./Call_variant.sh 16C-1_S101_L008_R1_001.fastq.gz_hg19_bwa_align_sorted_gpied_dedup_realign.bam"
	```
	
	```
	#get mutation numbers in ar region in my list
	cat 16C-1_S101_L008_R1_001.fastq.gz_hg19_bwa_align_sorted_gpied_dedup_realign.bam.chrX.raw_variants.vcf | grep -v "^#" | cut -f 1,2 > my.SNVs.txt
	vim published.SNVs.txt
	cat my.SNVs.txt | sort | uniq | sort > a_u.txt
	cat published.SNVs.txt | sort | uniq | sort > b_u.txt
	
	# shared mutations
	comm -12  a_u.txt  b_u.txt > c.txt
	
	# count bases in AR greion
	cat 16C-1_S101_L008_R1_001.fastq.gz_hg19_bwa_align_sorted_gpied_dedup_realign.bam.chrX.raw_variants.vcf | grep -v "^#"|  awk ' {if ($2 >= 66764055 && $2 <= 66944119)  print }' | wc -l
	```