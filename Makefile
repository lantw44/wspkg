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

DEBIAN_OUTPUT=        debian.out/217-meta.deb
DEBIAN_OUTPUT_TMPDIR= debian.out/217-meta
debian: debian.html $(DEBIAN_OUTPUT)
$(DEBIAN_OUTPUT): debian.control
	$(AT_MKDIR)mkdir -p $(DEBIAN_OUTPUT_TMPDIR)/DEBIAN
	$(AT_COPY)cp -pf debian.control $(DEBIAN_OUTPUT_TMPDIR)/DEBIAN/control
	$(AT_PKG)dpkg-deb --build $(DEBIAN_OUTPUT_TMPDIR) $(DEBIAN_OUTPUT)
debian.control: debian.control.in debian.control.sh debian.list
	$(AT_GEN)./debian.control.sh debian.control.in debian.list > "$@" $(RM_IF_FAIL)

FREEBSD_OUTPUT=       freebsd.out/217/Makefile
freebsd: freebsd.html $(FREEBSD_OUTPUT)
$(FREEBSD_OUTPUT): freebsd.makefile
	$(AT_MKDIR)mkdir -p freebsd.out/217
	$(AT_COPY)cp -pf freebsd.makefile freebsd.out/217/Makefile
freebsd.makefile: freebsd.makefile.in freebsd.makefile.sh freebsd.ports
	$(AT_GEN)./freebsd.makefile.sh freebsd.makefile.in freebsd.ports > "$@" $(RM_IF_FAIL)
freebsd.ports: freebsd.list freebsd.ports.sh freebsd.ports.find
	$(AT_GEN)./freebsd.ports.sh freebsd.list > "$@" $(RM_IF_FAIL)
freebsd.ports.find: freebsd.ports.find.c
	$(AT_CC)$(CC) -DHASH_TABLE_SIZE=50000 "$<" -o "$@"

clean:
	rm -f *.control *.makefile *.ports *.list
	rm -rf *.out
clean-exe:
	rm -f freebsd.ports.find
clean-doc:
	rm -f *.html

distclean: clean clean-exe clean-doc
