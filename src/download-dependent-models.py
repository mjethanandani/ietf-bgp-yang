import os

list_of_models =\
[ ["ietf-routing-policy", "draft-ietf-rtgwg-policy-model", "09"],
  ["ietf-bfd-types", "draft-ietf-bfd-yang", "17"],
  ["ietf-tcp", "draft-scharf-tcpm-yang-tcp", "04"] ]


def fetch_and_extract(draft, module, version):
    print("Fetching file " + draft + "with version " + version)
    draft_version = draft + "-" + version
    print(draft_version)
    os.system('curl -sO https://tools.ietf.org/id/%s.txt' %draft_version)
    print("Extracting Module from " + draft_version)
    os.system('xym %s.txt' %draft_version)
    print("Moving module " + module + " to ../bin/dependent")
    os.system('mv %s* ../bin/dependent' %module)
    print("Cleaning up ...")
    os.system('rm %s.txt' %draft_version)
        
for list in list_of_models:
    module, draft, version = list
    print(module)
    fetch_and_extract(draft, module, version)

os.system('rm *.yang')
