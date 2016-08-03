export OMP_NUM_THREADS=3

HG38_exl="/home/qan/delly2/human.hg38.excl.tsv"
DELLY2="/home/qan/delly2/delly_v0.7.3_parallel_linux_x86_64bit"
TYPE="DEL"
GENOME="/labshares/fanlab/anqin/REF/Hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa"

# somatic var calling
# $1 sample name, $2 bam file 

$DELLY2 call -t $TYPE -x $HG38_exl -o ${1}_${TYPE}.bcf -g $GENOME ${2} 

