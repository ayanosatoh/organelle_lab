#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 4
#$ -o a.log
#$ -e Download.log
#$ -N Download

# fastq�Ə�����fasterq-dump�Ń_�E�����[�h�ł���悤�ɃG�C���A�X��ݒ�
alias fastq='singularity exec -B /etc /usr/local/biotools/s/sra-tools:2.10.1--pl526haddd2b5_0 fasterq-dump --split-files -e 8'

#  SraAccList.txt�ɏ����Ă�����̂ɂ��āAdo done�̊Ԃ̏������J��Ԃ�
for i in $(cat SraAccList.txt)
do
# fasterq-dump��fastq�t�@�C�����_�E�����[�h���Ă���
  fastq $i
# ���O�t�@�C���Ɏ��̃T���v���Ɉړ�����|���L������(�G���[���ɏꏊ���킩��)
# next sample�Ə����Ă��邪�Anect sample -> $i �Ƃł�����΃T���v���̃A�N�Z�b�V�������\�������̂ŁA������̂ق����ǂ���������Ȃ�
  echo -e \\n next sample  \\n >> Download.log 
# gzip�ň��k����
  gzip *.fastq
done

# �󔒂̃��O�t�@�C������������
rm -f a.log