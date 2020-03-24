#!/bin/sh

DEPENDENT_MODELS="ietf-routing-policy ietf-bfd-types"
DRAFT="draft-ietf-rtgwg-policy-model draft-ietf-bfd-yang"
DRAFT_VERSION="09 17"

fetch_draft_and_extract_module() {
  echo "fetching file $1 with version $2..."
  curl -sO https://tools.ietf.org/id/$1-$2.txt
  echo "extracting module ..."
  xym $1-$2.txt
  echo "Moving $3 into ../bin/dependent"
  mv $3* ../bin/dependent
  echo "Cleaning up ..."
  rm $1-$2.txt
}

if [ ! -f ../bin/dependent/ietf-routing-policy*.yang ];
then
    fetch_draft_and_extract_module draft-ietf-rtgwg-policy-model 09 \
				   ietf-routing-policy
fi
if [ ! -f ../bin/dependent/ietf-bfd-types*.yang ];
then
   fetch_draft_and_extract_module draft-ietf-bfd-yang 17 ietf-bfd-types
fi

# fetch all dependent modules
if [ ! -d ../../iana ];
then
    mkdir ../../iana
    rsync -avz --delete rsync.ietf.org::iana/yang-parameters ../../iana
fi

# cleanup
rm -rf *.yang
rm -rf example*
