#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 4
#$ -o out.log
#$ -e error.log

# SraAccListを参照してループ処理
for i in $(cat SraAccList.txt)
do
# _2fastq.gzがあればペアエンド
if [ -e ${i}_2.fastq.gz ]; then
  echo -e \\n start analysis of $i \\n >> error.log 
  echo -e \\n start analysis of $i \\n >> out.log
  export GEA_HOME=/lustre7/singularity/images/gene_expression_analysis
  export GEA_SINGULARITY=/lustre7/singularity/3.7.1/bin/singularity
  ${GEA_SINGULARITY} exec \
  -B ${GEA_HOME}/refs:${GEA_HOME}/refs \
  ${GEA_HOME}/gene_expression_analysis.sif \
  GeneExpressionAnalysisSingle.sh \
   $i \
  hg38 \
  ${i}_1.fastq.gz \
  ${i}_2.fastq.gz
# なければシングルエンド
else
echo -e \\n start analysis of $i \\n >> error.log 
  echo -e \\n start analysis of $i \\n >> out.log
  export GEA_HOME=/lustre7/singularity/images/gene_expression_analysis
  export GEA_SINGULARITY=/lustre7/singularity/3.7.1/bin/singularity
  ${GEA_SINGULARITY} exec \
  -B ${GEA_HOME}/refs:${GEA_HOME}/refs \
  ${GEA_HOME}/gene_expression_analysis.sif \
  GeneExpressionAnalysisSingle.sh \
   $i \
  hg38 \
  ${i}.fastq.gz
fi
done