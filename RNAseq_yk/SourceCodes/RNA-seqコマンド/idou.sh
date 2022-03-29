mkdir -p idou
ls -d */ >file1.txt
tr -d '/' < file1.txt > file2.txt
tr -d 'idou' < file2.txt > file3.txt
rm -f file1.txt
rm -f file2.txt

for i in $(cat file3.txt)
do
mkdir -p idou/${i}

cd ${i}
ls -d */ >file4.txt
tr -d '/' < file4.txt > file5.txt
rm -f file4.txt

for j in $(cat file5.txt)
do
cd ${j}
cd featureCounts
cp ${j}_count.txt ../../../idou/${i}
cd ../..
done

rm -f file5.txt
cd ..

done
rm -f file3.txt
