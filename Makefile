.POSIX:
.PHONY: all clean debian freebsd
.SUFFIXES: .pkg .list

V=0
CC=c99

AT=$(AT_$(V))
AT_0=@echo "  GEN     "$@;
AT_1=

AT_CC=$(AT_CC_$(V))
AT_CC_0=@echo "  CC      "$@;
AT_CC_1=

AT_PKG=$(AT_PKG_$(V))
AT_PKG_0=@echo "  PKG     "$@;
AT_PKG_1=

AT_COPY=$(AT_COPY_$(V))
AT_COPY_0=@echo "  COPY    "$@;
AT_COPY_1=

AT_MKDIR=$(AT_MKDIR_$(V))
AT_MKDIR_0=@echo "  MKDIR   "$@;
AT_MKDIR_1=

all: debian freebsd

.pkg.list: packages.h packages.sh
	@echo "===> Generating list file $@"
	$(AT)./packages.sh `echo "$<" | cut -d . -f 1` | sort | uniq > "$@" || rm -f "$@"

DEBIAN_OUTPUT=        debian.out/217-meta.deb
DEBIAN_OUTPUT_TMPDIR= debian.out/217-meta
debian: $(DEBIAN_OUTPUT)
$(DEBIAN_OUTPUT): debian.control
	@echo "===> Creating meta-package $(DEBIAN_OUTPUT)"
	$(AT_MKDIR)mkdir -p $(DEBIAN_OUTPUT_TMPDIR)/DEBIAN
	$(AT_COPY)cp -pf debian.control $(DEBIAN_OUTPUT_TMPDIR)/DEBIAN/control
	$(AT_PKG)dpkg-deb --build $(DEBIAN_OUTPUT_TMPDIR) $(DEBIAN_OUTPUT)
debian.control: debian.control.in debian.control.sh debian.list
	@echo "===> Generating $@"
	$(AT)./debian.control.sh debian.control.in debian.list > "$@" || rm -f "$@"

FREEBSD_OUTPUT=       freebsd.out/217/Makefile
freebsd: $(FREEBSD_OUTPUT)
$(FREEBSD_OUTPUT): freebsd.makefile
	@echo "===> Creating meta-ports $(FREEBSD_OUTPUT)"
	$(AT_MKDIR)mkdir -p freebsd.out/217
	$(AT_COPY)cp -pf freebsd.makefile freebsd.out/217/Makefile
freebsd.makefile: freebsd.makefile.in freebsd.makefile.sh freebsd.ports
	@echo "===> Generating $@"
	$(AT)./freebsd.makefile.sh freebsd.makefile.in freebsd.ports > "$@" || rm -f "$@"
freebsd.ports: freebsd.list freebsd.ports.sh freebsd.ports.find
	@echo "===> Generating $@"
	$(AT)./freebsd.ports.sh freebsd.list > "$@" || rm -f "$@"
freebsd.ports.find: freebsd.ports.find.c
	$(AT_CC)$(CC) -DHASH_TABLE_SIZE=50000 "$<" -o "$@"

clean:
	rm -f *.control *.makefile *.ports *.list
	rm -f freebsd.ports.find
	rm -rf *.out
