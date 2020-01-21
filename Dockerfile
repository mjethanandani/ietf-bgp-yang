FROM fredrikjanssonse/etsi-sol006-base-image:6.6
# FROM mjethanandani/compile-yang:latest

RUN perl -0777 -i -pe 's|<operational>\n      <enabled>false</enabled>|<operational><enabled>true</enabled>|g' /opt/confd/etc/confd/confd.conf

# RUN apt-get update; apt-get install -y python-pip libxml2 libxml2-utils; rm -rf /tmp/*
# RUN pip install paramiko

ADD bin/*.yang src/
ADD bin/submodules/*.yang src/
ADD src/yang/example-bgp-configuration-*.xml src/
ADD bin/yang-parameters/*.yang src/
ADD confdc-run-test.sh /

CMD ["/confdc-run-test.sh"]
