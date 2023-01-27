#!/bin/sh

#
# Does the user have all the IETF published models.
#
if [ ! -d ../bin/yang-parameters ]; then
   rsync -avz --delete rsync.iana.org::assignments/yang-parameters ../bin/
fi

for i in ../bin/ietf-*\@$(date +%Y-%m-%d).yang
do
    name=$(echo $i | cut -f 1-3 -d '.')
    echo "Validating $name.yang"
    if test "${name#^example}" = "$name"; then
        response=`pyang --ietf --lint --strict --canonical -p ../bin/yang-parameters -p ../bin/submodules -p ../bin -f tree --max-line-length=72 --tree-line-length=69 $name.yang > $name-tree.txt.tmp`
    else            
        response=`pyang --ietf --strict --canonical -p ../bin/yang-parameters -p ../bin/submodules -p ../bin -f tree --max-line-length=72 --tree-line-length=69 $name.yang > $name-tree.txt.tmp`
    fi
    if [ $? -ne 0 ]; then
        printf "$name.yang failed pyang validation\n"
        printf "$response\n\n"
        echo
	rm yang/*-tree.txt.tmp
        exit 1
    fi
    fold -w 71 $name-tree.txt.tmp > $name-tree.txt
    response=`yanglint -p ../bin/yang-parameters -p ../bin/submodules -p ../bin $name.yang -i`
    if [ $? -ne 0 ]; then
        printf "$name.yang failed yanglint validation\n"
        printf "$response\n\n"
        echo
        exit 1
    fi
done
rm ../bin/*-tree.txt.tmp

# Generate a sub-tree with a depth of 3

for i in ../bin/ietf-bgp\@$(date +%Y-%m-%d).yang
do
    name=$(echo $i | cut -f 1-3 -d '.')
    echo "Generating abridged tree diagram for $name.yang"
    if test "${name#^example}" = "$name"; then
       response=`pyang --lint --strict --canonical -p ../../yang-parameters -p ../bin/submodules -p ../bin -f tree --tree-depth=3 --max-line-length=72 --tree-line-length=69 $name.yang > $name-sub-tree.txt.tmp`
    else            
        response=`pyang --ietf --strict --canonical -p ../bin/yang-parameters -p ../bin/submodules -p ../bin -f tree --tree-depth=3 --max-line-length=72 --tree-line-length=69 $name.yang > $name-sub-tree.txt.tmp`
    fi
    if [ $? -ne 0 ]; then
        printf "$name.yang failed generation of sub-tree diagram\n"
        printf "$response\n\n"
        echo
	rm yang/*-sub-tree.txt.tmp
        exit 1
    fi
    fold -w 71 $name-sub-tree.txt.tmp > $name-sub-tree.txt
done
rm ../bin/*-sub-tree.txt.tmp

echo "Generating sub-tree diagram for policy"
for i in ../bin/ietf-bgp-policy\@$(date +%Y-%m-%d).yang
do
    name=$(echo $i | cut -f 1-3 -d '.')
    echo "Validating $name.yang"
    if test "${name#^example}" = "$name"; then
        response=`pyang --lint --strict --canonical -p ../bin/yang-parameters -p ../bin/submodules -p ../bin -f tree --tree-depth=1 --max-line-length=72 --tree-line-length=69 $name.yang > $name-sub-tree.txt.tmp`
    else            
        response=`pyang --ietf --strict --canonical -p ../bin/yang-parameters -p ../bin/submodules -p ../bin -f tree --tree-depth=1 --max-line-length=72 --tree-line-length=69 $name.yang > $name-sub-tree.txt.tmp`
    fi
    if [ $? -ne 0 ]; then
        printf "$name.yang failed generation of sub-tree diagram\n"
        printf "$response\n\n"
        echo
	rm yang/*sub-tree.txt.tmp
        exit 1
    fi
    fold -w 71 $name-sub-tree.txt.tmp > $name-sub-tree.txt
done
rm ../bin/*-sub-tree.txt.tmp

for i in ../bin/ietf-bgp\@$(date +%Y-%m-%d).yang
do
    name=$(echo $i | cut -f 1-3 -d '.')
    echo "Generating sub-tree diagram for rib from  $name.yang"
    if test "${name#^example}" = "$name"; then
	response=`pyang --lint --strict --canonical -p ../bin/yang-parameters -p ../bin/submodules -p ../bin -f tree --tree-path=rib/afi-safis --tree-depth=8 --max-line-length=72 --tree-line-length=69 $name.yang > $name-rib-tree.txt.tmp`
    else            
        response=`pyang --ietf --strict --canonical -p ../bin/yang-parameters -p ../bin/submodules -p ../bin -f tree --tree-path=rib/afi-safis --tree-depth=8 --max-line-length=72 --tree-line-length=69 $name.yang > $name-rib-tree.txt.tmp`
    fi
    if [ $? -ne 0 ]; then
        printf "$name.yang failed generation of sub-tree diagram for rib\n"
        printf "$response\n\n"
        echo
	#rm yang/*-rib-tree.txt.tmp
        #exit 1
    fi
    fold -w 71 $name-rib-tree.txt.tmp > $name-rib-tree.txt
done
rm ../bin/*-rib-tree.txt.tmp

echo "Validating examples"

# Validate BGP examples. Skip a.1.3 as it has schema mount
# in it, and that is not supported by any tool.
for i in yang/example-bgp-configuration-a.1.[0-2].xml
do
    name=$(echo $i | cut -f 1-3 -d '.')
    echo "Validating $name.xml"
    response=`yanglint -ii -t config -p ../bin/yang-parameters -p ../bin -p ../bin/submodules ../bin/yang-parameters/ietf-network-instance@2019-01-21.yang ../bin/iana-bgp-types\@$(date +%Y-%m-%d).yang ../bin/iana-bgp-community-types\@$(date +%Y-%m-%d).yang  ../bin/ietf-bgp\@$(date +%Y-%m-%d).yang $name.xml`
    if [ $? -ne 0 ]; then
       printf "failed (error code: $?)\n"
       printf "$response\n\n"
       echo
       exit 1
    fi
done

# Validate BGP Policy examples
for i in yang/example-bgp-configuration-a.1.[4-5].xml
do
    name=$(echo $i | cut -f 1-3 -d '.')
    echo "Validating $name.xml"
    response=`yanglint -ii -t config -p ../bin/yang-parameters -p ../bin -p ../bin/submodules ../bin/yang-parameters/ietf-network-instance@2019-01-21.yang ../bin/iana-bgp-types\@$(date +%Y-%m-%d).yang ../bin/iana-bgp-community-types\@$(date +%Y-%m-%d).yang ../bin/ietf-bgp\@$(date +%Y-%m-%d).yang ../bin/ietf-bgp-policy\@$(date +%Y-%m-%d).yang $name.xml`
    if [ $? -ne 0 ]; then
       printf "failed (error code: $?)\n"
       printf "$response\n\n"
       echo
       exit 1
    fi
done
