# FolderList.txt���Q�Ƃ��ă��[�v����
for i in $(cat FolderList.txt)
do
# cd�R�}���h�ňړ�
cd ${i}/
# qsub�ɓ�����
qsub gene_expression_analysis.sh
# ���̃t�H���_�ɖ߂�
cd ..
done
# qstat�œ������Ă��邱�Ƃ��m�F
qstat