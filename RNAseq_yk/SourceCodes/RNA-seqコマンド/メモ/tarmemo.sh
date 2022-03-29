#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 4
#$ -o out.log
#$ -e error.log

alias pigz='singularity exec -B /etc /usr/local/biotools/p/pigz:2.3.4 pigz'

tar -cvzf DNBSEQ.tar.gz DNBSEQ/
tar -cvzf E_MTAB_5618.tar.gz E_MTAB_5618/
tar -cvzf RNAseq_2016.tar.gz RNAseq_2016/