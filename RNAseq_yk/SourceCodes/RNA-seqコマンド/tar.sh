#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 4
#$ -o tar_out.log
#$ -e tar_error.log

# tar ��gzip������������pigz���Apigz�Ə����Ύg����悤�ɂ��Ă���
alias pigz='singularity exec -B /etc /usr/local/biotools/p/pigz:2.3.4 pigz'

# �f�B���N�g���������񂳂ꂽfile2.txt ����k����
ls -d */ >file1.txt
tr -d '/' < file1.txt > file2.txt

rm -f file1.txt

# file2.txt���Q�Ƃ��ă��[�v����
for i in $(cat file2.txt)
do
# �A�[�J�C�u���k����
tar -c ${i}/ | pigz --best > ${i}.tar.gz
done

# file2���폜
rm -f file2.txt