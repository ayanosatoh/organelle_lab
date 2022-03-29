# FolderList.txtを参照してループ処理
for i in $(cat FolderList.txt)
do
# フォルダを作成
	mkdir $i
# 3つのファイルを移動させる
	cp DL.sh ${i}/
	cp gene_expression_analysis.sh ${i}/
	cp tar.sh ${i}/
done