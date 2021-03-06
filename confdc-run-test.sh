#!/bin/bash

echo "Testing"

set -e

source /opt/confd/confdrc
cd src
FXS="iana-bfd-types ietf-bfd-types ietf-key-chain ietf-routing ietf-interfaces ietf-bgp-types ietf-routing-policy ietf-if-l3-vlan ieee802-dot1q-types ietf-interfaces-common iana-if-type ietf-routing-types ietf-tcp-client ietf-tcp-server ietf-tcp-common ietf-tcp ietf-bgp ietf-bgp-policy"

echo "Testing compilation"
CONFD_OPTS="--fail-on-warnings"
CONFD_OPTS=""
for i in ${FXS}
do
    echo "Compiling $i.yang"
    confdc -c $CONFD_OPTS -o /opt/confd/etc/confd/$i.fxs $i\@*.yang
done

echo "Starting ConfD"
confd
confd --wait-started

echo "Loading Data for example a.1.0"
confd_load -l -m example-bgp-configuration-a.1.0.xml

echo "Loading Data for example a.1.1"
confd_load -l -m example-bgp-configuration-a.1.1.xml

echo "Loading Data for example a.1.2"
confd_load -l -m example-bgp-configuration-a.1.2.xml

echo "Loading Data for example a.1.3"
confd_load -l -m example-bgp-configuration-a.1.3.xml

echo "Loading Data for example a.1.4"
confd_load -l -m example-bgp-configuration-a.1.4.xml

# Don't do this in the actual test, just waste of cycles
# echo "Stopping ConfD"
# confd --stop
