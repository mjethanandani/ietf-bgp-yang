#!/bin/sh
for i in ../build/ietf-*\@$(date +%Y-%m-%d).yang
do
	filename=$(basename "$i")
        name="${filename%.*}"
        echo $name
	pyang --ietf -p ../build -f tree ../build/$name.yang > ../build/$name-tree.txt.tmp
	fold -w 71 ../build/$name-tree.txt.tmp > ../build/$name-tree.txt
done
rm ../build/*-tree.txt.tmp
