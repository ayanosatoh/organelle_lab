# FolderList.txt���Q�Ƃ��ă��[�v����
for i in $(cat FolderList.txt)
do
# �t�H���_���쐬
	mkdir $i
# 3�̃t�@�C�����ړ�������
	cp DL.sh ${i}/
	cp gene_expression_analysis.sh ${i}/
	cp tar.sh ${i}/
done