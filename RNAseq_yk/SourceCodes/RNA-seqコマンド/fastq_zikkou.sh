# FolderList.txt���Q�Ƃ��ă��[�v����
for i in $(cat FolderList.txt)
do
# FolderList.txt�ɏ����Ă���t�H���_�Ɉړ�����
cd ${i}/
#DL.sh��qsub�ɓ�����
qsub DL.sh
# ���̃t�H���_�ɖ߂�
cd ..
done
# qstat��q�W���u��\���A�������Ă��邱�Ƃ��m�F����
qstat