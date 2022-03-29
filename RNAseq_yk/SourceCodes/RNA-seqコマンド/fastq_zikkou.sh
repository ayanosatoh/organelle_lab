# FolderList.txtを参照してループ処理
for i in $(cat FolderList.txt)
do
# FolderList.txtに書いてあるフォルダに移動する
cd ${i}/
#DL.shをqsubに投げる
qsub DL.sh
# 元のフォルダに戻る
cd ..
done
# qstatでqジョブを表示、投げられていることを確認する
qstat