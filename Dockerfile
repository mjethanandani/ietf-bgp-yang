FROM mjethanandani/build-yang:1.0

# Everything below is draft specific

RUN mkdir -p /git/ietf-bgp-model/draft/ /git/ietf-bgp-model/src/ /git/ietf-bgp-model/src/yang /git/ietf-bgp-model/bin/

ADD .git/ /git/ietf-bgp-model/
ADD src/validate-and-gen-trees.sh /git/ietf-bgp-model/src
ADD src/addstyle.sed /git/ietf-bgp-model/src
ADD src/download-dependent-models.py /git/ietf-bgp-model/src
ADD src/insert-figures.sh /git/ietf-bgp-model/src
ADD src/replace.sh /git/ietf-bgp-model/src/replace.sh
ADD src/yang/ /git/ietf-bgp-model/src/yang/
ADD src/yang/example* /git/ietf-bgp-model/src/yang/
ADD draft/Makefile /git/ietf-bgp-model/draft/
ADD draft/draft-ietf-idr-bgp-model.xml /git/ietf-bgp-model/draft/
ADD start.sh /

CMD ["./start.sh"]
