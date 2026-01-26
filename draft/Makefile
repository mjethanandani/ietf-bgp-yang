# In case your system doesn't have any of these tools:
# https://pypi.python.org/pypi/xml2rfc
# https://github.com/cabo/kramdown-rfc2629
# https://github.com/Juniper/libslax/tree/master/doc/oxtradoc
# https://tools.ietf.org/tools/idnits/

xml2rfc ?= xml2rfc
kramdown-rfc2629 ?= kramdown-rfc2629
oxtradoc ?= oxtradoc
idnits ?= idnits

draft := $(basename $(lastword $(sort $(wildcard draft-*.xml)) $(sort $(wildcard draft-*.md)) $(sort $(wildcard draft-*.org)) ))

ifeq (,$(draft))
$(warning No file named draft-*.md or draft-*.xml or draft-*.org)
$(error Read README.md for setup instructions)
endif

draft_type := $(suffix $(firstword $(wildcard $(draft).md $(draft).org $(draft).xml) ))

current_ver := $(shell git tag | grep '$(draft)-[0-9][0-9]' | tail -1 | sed -e"s/.*-//")
ifeq "${current_ver}" ""
next_ver ?=
else
next_ver ?= $(shell printf "%.2d" $$((1$(current_ver)-99)))
endif
next := $(draft)-$(next_ver)

.PHONY: latest submit clean rib-clean

#latest: $(draft).txt $(draft).html

default: $(next).xml $(next).txt $(next).html rib

idnits: $(next).txt
	$(idnits) $<

clean:
	-rm -rf ../bin
	-rm -f $(draft).txt $(draft).html index.html
	-rm -f $(draft)-[0-9][0-9].*
ifeq (md,$(draft_type))
	-rm -f $(draft).xml
endif
ifeq (org,$(draft_type))
	-rm -f $(draft).xml
endif
	-rm -f ../bin/*\@$(shell date +%Y)-*-*-tree.txt*
	-rm -f ../bin/*\@$(shell date +%Y)-*-*.yang
	-rm -f ../bin/submodules/*\@$(shell date +%Y)*.yang
	-rm -f ../bin/submodules/*\@$(shell date +%Y)*-*-*.yang

$(next).xml: $(draft).xml ../src/yang/ietf-bgp-capabilities.yang ../src/yang/ietf-bgp-common-multiprotocol.yang ../src/yang/ietf-bgp-common-errors.yang ../src/yang/ietf-bgp-common-structure.yang ../src/yang/ietf-bgp-common.yang ../src/yang/ietf-bgp-neighbor.yang ../src/yang/iana-bgp-notification.yang ../src/yang/ietf-bgp-policy.yang ../src/yang/iana-bgp-types.yang ../src/yang/iana-bgp-community-types.yang ../src/yang/ietf-bgp.yang rib
	sed -e"s/$(basename $<)-latest/$(basename $@)/" -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" $< > $@
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-capabilities.yang > ../bin/submodules/ietf-bgp-capabilities\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-common-errors.yang > ../bin/submodules/ietf-bgp-common-errors\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-common-multiprotocol.yang > ../bin/submodules/ietf-bgp-common-multiprotocol\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-common-structure.yang > ../bin/submodules/ietf-bgp-common-structure\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-common.yang > ../bin/submodules/ietf-bgp-common\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-neighbor.yang > ../bin/submodules/ietf-bgp-neighbor\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-policy.yang > ../bin/ietf-bgp-policy\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/iana-bgp-notification.yang > ../bin/submodules/iana-bgp-notification\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/iana-bgp-types.yang > ../bin/iana-bgp-types\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/iana-bgp-rib-types.yang > ../bin/iana-bgp-rib-types\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/iana-bgp-community-types.yang > ../bin/iana-bgp-community-types\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp.yang > ../bin/ietf-bgp\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/example-newafi-bgp.yang > ../bin/example-newafi-bgp\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/example-newco-bgp-a.2.yang > ../bin/example-newco-bgp-a.2\@$(shell date +%Y-%m-%d).yang

	cd ../src; python download-dependent-models.py; ./validate-and-gen-trees.sh; cd ..;
	../src/insert-figures.sh $@ > tmp; mv tmp $@

rib: ../src/yang/ietf-bgp-rib.yang ../src/yang/ietf-bgp-rib-attributes.yang ../src/yang/ietf-bgp-rib-tables.yang ../src/yang/iana-bgp-rib-types.yang
	-mkdir -p ../bin
	-mkdir -p ../bin/submodules
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-rib.yang > ../bin/submodules/ietf-bgp-rib\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-rib-attributes.yang > ../bin/submodules/ietf-bgp-rib-attributes\@$(shell date +%Y-%m-%d).yang
	sed -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" ../src/yang/ietf-bgp-rib-tables.yang > ../bin/submodules/ietf-bgp-rib-tables\@$(shell date +%Y-%m-%d).yang

.INTERMEDIATE: $(draft).xml
%.xml: %.md
	$(kramdown-rfc2629) $< > $@

%.xml: %.org
	$(oxtradoc) -m outline-to-xml -n "$@" $< > $@

%.txt: %.xml
	$(xml2rfc) $< -o $@ --text
	$(idnits) $@

ifeq "$(shell uname -s 2>/dev/null)" "Darwin"
sed_i := sed -i ''
else
sed_i := sed -i
endif

%.html: %.xml
	$(xml2rfc) $< -o $@ --html
	$(sed_i) -f ../src/addstyle.sed $@


### Below this deals with updating gh-pages

GHPAGES_TMP := /tmp/ghpages$(shell echo $$$$)
.TRANSIENT: $(GHPAGES_TMP)
ifeq (,$(TRAVIS_COMMIT))
GIT_ORIG := $(shell git branch | grep '*' | cut -c 3-)
else
GIT_ORIG := $(TRAVIS_COMMIT)
endif

# Only run upload if we are local or on the master branch
IS_LOCAL := $(if $(TRAVIS),,true)
ifeq (master,$(TRAVIS_BRANCH))
IS_MASTER := $(findstring false,$(TRAVIS_PULL_REQUEST))
else
IS_MASTER :=
endif

index.html: $(draft).html
	cp $< $@

ghpages: index.html $(draft).txt
ifneq (,$(or $(IS_LOCAL),$(IS_MASTER)))
	mkdir $(GHPAGES_TMP)
	cp -f $^ $(GHPAGES_TMP)
	git clean -qfdX
ifeq (true,$(TRAVIS))
	git config user.email "ci-bot@example.com"
	git config user.name "Travis CI Bot"
	git checkout -q --orphan gh-pages
	git rm -qr --cached .
	git clean -qfd
	git pull -qf origin gh-pages --depth=5
else
	git checkout gh-pages
	git pull
endif
	mv -f $(GHPAGES_TMP)/* $(CURDIR)
	git add $^
	if test `git status -s | wc -l` -gt 0; then git commit -m "Script updating gh-pages."; fi
ifneq (,$(GH_TOKEN))
	@echo git push https://github.com/$(TRAVIS_REPO_SLUG).git gh-pages
	@git push https://$(GH_TOKEN)@github.com/$(TRAVIS_REPO_SLUG).git gh-pages
endif
	-git checkout -qf "$(GIT_ORIG)"
	-rm -rf $(GHPAGES_TMP)
endif
