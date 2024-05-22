import os

list_of_ietf_models =\
[ ["ietf-tcp", "draft-ietf-tcpm-yang-tcp", "09"],
  ["ietf-if-extensions", "draft-ietf-netmod-intf-ext-yang", "10"],
  ["ietf-if-vlan-encapsulation", "draft-ietf-netmod-sub-intf-vlan-model", "07"],
  ["ietf-if-flexible-encapsulation", "draft-ietf-netmod-sub-intf-vlan-model", "07"],
  ["ietf-crypto-types", "draft-ietf-netconf-crypto-types", "20"],
  ["ietf-tcp-client", "draft-ietf-netconf-tcp-client-server", "10"],
  ["ietf-tcp-server", "draft-ietf-netconf-tcp-client-server", "10"],
  ["ietf-tcp-common", "draft-ietf-netconf-tcp-client-server", "10"],
  ["ietf-bfd-large", "draft-ietf-bfd-large-packets", "07"] ]


list_of_ieee_models =\
    [ ["ieee802-dot1q-types", "www.ieee802.org/1/files/public/YANGs/"] ]

def fetch_and_extract(draft, module, version):
    print("Fetching file " + draft + " with version " + version)
    draft_version = draft + "-" + version
    print(draft_version)
    os.system('curl -sO https://www.ietf.org/archive/id/%s.txt' %draft_version)
    print("Extracting Module from " + draft_version)
    os.system('xym %s.txt' %draft_version)
    print("Moving module " + module + " to ../bin/dependent/")
    os.system('mv %s* ../bin/dependent/' %module)
    print("Cleaning up ...")
    os.system('rm %s.txt' %draft_version)

def fetch(module, path):
    file = path + module + ".yang.txt"
    print("Fetching file " + file)
    os.system('curl -sO http://%s' %file)
    model = module + ".yang"
    print("Moving module " + model + " to ../bin/dependent/")
    os.system("mv '%s'.txt ../bin/dependent/'%s'" %(model, model))

os.system("mkdir -p ../bin/dependent")

for list in list_of_ietf_models:
    module, draft, version = list
    print(module)
    fetch_and_extract(draft, module, version)

# for list in list_of_ieee_models:
#    module, path = list
#    print(module)
#    fetch(module, path)

os.system('rm *.yang')
