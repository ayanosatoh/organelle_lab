# FolderList.txtを参照してループ処理
for i in $(cat FolderList.txt)
do
# cdコマンドで移動
cd ${i}/
# qsubに投げる
qsub gene_expression_analysis.sh
# 元のフォルダに戻る
cd ..
done
# qstatで投げられていることを確認
qstat