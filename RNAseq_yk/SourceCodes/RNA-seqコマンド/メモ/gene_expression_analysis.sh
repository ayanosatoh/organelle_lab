#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 4
#$ -o out(�T���v����).log
#$ -e error(�T���v����).log

export GEA_HOME=/lustre7/singularity/images/gene_expression_analysis
export GEA_SINGULARITY=/lustre7/singularity/3.7.1/bin/singularity
${GEA_SINGULARITY} exec \
-B ${GEA_HOME}/refs:${GEA_HOME}/refs \
${GEA_HOME}/gene_expression_analysis.sif \
GeneExpressionAnalysisSingle.sh \
�t�H���_�����L�� \
hg19 or hg38 ���L�� \
1�{�ڂ̍���fastq(.gz�̕����ǂ�) \
2�{�ڂ̍���fastq(.gz�̕����ǂ�)