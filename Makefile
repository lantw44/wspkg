# vim: set ts=8 sts=8 sw=8 ft=make:

.POSIX:
.PHONY: all clean clean-exe clean-doc distclean debian freebsd readme
.SUFFIXES: .pkg .list .txt .html

V=0
CC=c99

RM_IF_FAIL= || { rm -f "$@" && false; }

include Makefile.at

all: readme debian freebsd
readme: README.html

.pkg.list: packages.h packages.sh
	$(AT_CPP)./packages.sh `echo "$<" | cut -d . -f 1` | sort | uniq > "$@" $(RM_IF_FAIL)

.txt.html:
	-$(AT_DOC)asciidoc -b html -o "$@" "$<"

include Makefile.debian
include Makefile.freebsd

clean:
	rm -f *.control *.makefile *.ports *.list
	rm -rf *.out
clean-exe:
	rm -f freebsd.ports.find
clean-doc:
	rm -f *.html

distclean: clean clean-exe clean-doc
