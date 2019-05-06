FROM mjethanandani/sol-006:latest
RUN perl -0777 -i -pe 's|<operational>\n      <enabled>false</enabled>|<operational><enabled>true</enabled>|g' /opt/confd/etc/confd/confd.conf

RUN apt-get update; apt-get install -y python-pip libxml2 libxml2-utils; rm -rf /tmp/*
RUN pip install paramiko

ADD bin/*.yang src/
ADD bin/submodules/*.yang src/
ADD src/yang/*.xml src/
ADD bin/yang-parameters/*.yang src/
ADD run-test.sh /

CMD ["/run-test.sh"]
