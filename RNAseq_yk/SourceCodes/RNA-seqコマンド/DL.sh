#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 4
#$ -o a.log
#$ -e Download.log
#$ -N Download

# fastqと書けばfasterq-dumpでダウンロードできるようにエイリアスを設定
alias fastq='singularity exec -B /etc /usr/local/biotools/s/sra-tools:2.10.1--pl526haddd2b5_0 fasterq-dump --split-files -e 8'

#  SraAccList.txtに書いてあるものについて、do doneの間の処理を繰り返す
for i in $(cat SraAccList.txt)
do
# fasterq-dumpでfastqファイルをダウンロードしてくる
  fastq $i
# ログファイルに次のサンプルに移動する旨を記入する(エラー時に場所がわかる)
# next sampleと書いているが、nect sample -> $i とでもすればサンプルのアクセッションが表示されるので、そちらのほうが良いかもしれない
  echo -e \\n next sample  \\n >> Download.log 
# gzipで圧縮する
  gzip *.fastq
done

# 空白のログファイルを消去する
rm -f a.log