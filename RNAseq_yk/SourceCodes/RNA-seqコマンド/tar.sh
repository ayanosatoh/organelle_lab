#!/bin/sh
#$ -S /bin/sh
#$ -cwd
#$ -l s_vmem=8G -l mem_req=8G
#$ -pe def_slot 4
#$ -o tar_out.log
#$ -e tar_error.log

# tar をgzipを高速化したpigzを、pigzと書けば使えるようにしている
alias pigz='singularity exec -B /etc /usr/local/biotools/p/pigz:2.3.4 pigz'

# ディレクトリ名が羅列されたfile2.txt をさk末井
ls -d */ >file1.txt
tr -d '/' < file1.txt > file2.txt

rm -f file1.txt

# file2.txtを参照してループ処理
for i in $(cat file2.txt)
do
# アーカイブ圧縮する
tar -c ${i}/ | pigz --best > ${i}.tar.gz
done

# file2を削除
rm -f file2.txt