for i in yang/ietf-*\@$(date +%Y-%m-%d).yang
do
	name=$(echo $i | cut -f 1 -d '.')
	echo $name
	pyang -p ../ -f tree $name.yang > $name-tree.txt.tmp
	fold -w 71 $name-tree.txt.tmp > $name-tree.txt
done
rm yang/*-tree.txt.tmp
