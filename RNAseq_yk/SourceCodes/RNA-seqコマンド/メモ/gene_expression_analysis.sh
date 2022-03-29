#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 4
#$ -o out(サンプル名).log
#$ -e error(サンプル名).log

export GEA_HOME=/lustre7/singularity/images/gene_expression_analysis
export GEA_SINGULARITY=/lustre7/singularity/3.7.1/bin/singularity
${GEA_SINGULARITY} exec \
-B ${GEA_HOME}/refs:${GEA_HOME}/refs \
${GEA_HOME}/gene_expression_analysis.sif \
GeneExpressionAnalysisSingle.sh \
フォルダ名を記入 \
hg19 or hg38 を記入 \
1本目の鎖のfastq(.gzの方が良い) \
2本目の鎖のfastq(.gzの方が良い)