#!/bin/sh

for i in ../bin/*\@$(date +%Y-%m-%d).yang
do
    name=$(echo $i | cut -f 1-3 -d '.')
    echo "Validating $name.yang"
    if test "${name#^example}" = "$name"; then
        response=`pyang --lint --strict --canonical -p ../../iana/yang-parameters -p ../bin/submodules -p ../bin -f tree --max-line-length=72 --tree-line-length=69 $name.yang > $name-tree.txt.tmp`
    else            
        response=`pyang --ietf --strict --canonical -p ../../iana/yang-parameters -p ../bin/submodules -p ../bin -f tree --max-line-length=72 --tree-line-length=69 $name.yang > $name-tree.txt.tmp`
    fi
    if [ $? -ne 0 ]; then
        printf "$name.yang failed pyang validation\n"
        printf "$response\n\n"
        echo
	rm yang/*-tree.txt.tmp
        exit 1
    fi
    fold -w 71 $name-tree.txt.tmp > $name-tree.txt
    response=`yanglint -p ../../iana/yang-parameters -p ../src/yang/submodules -p ../src/yang $name.yang -i`
    if [ $? -ne 0 ]; then
        printf "$name.yang failed yanglint validation\n"
        printf "$response\n\n"
        echo
        exit 1
    fi
done
rm ../bin/*-tree.txt.tmp

echo "Validating examples"

for i in yang/example-bgp-configuration-*.xml
do
    name=$(echo $i | cut -f 1-2 -d '.')
    echo "Validating $name.xml"
    response=`yanglint -s -i -t auto -p ../../iana/yang-parameters -p ../bin -p ../bin/submodules ../bin/ietf-bgp\@$(date +%Y-%m-%d).yang $name.xml`
    if [ $? -ne 0 ]; then
       printf "failed (error code: $?)\n"
       printf "$response\n\n"
       echo
       exit 1
    fi
done
