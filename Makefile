.POSIX:
.PHONY: all clean debian freebsd
.SUFFIXES: .pkg .list

all: debian freebsd

.pkg.list: packages.h packages.sh
	@echo "==> Generating list file $@"
	./packages.sh `echo "$<" | cut -d . -f 1` | sort | uniq > "$@" || rm -f "$@"

DEBIAN_OUTPUT=        debian.out/217-meta.deb
DEBIAN_OUTPUT_TMPDIR= debian.out/217-meta
debian: $(DEBIAN_OUTPUT)
$(DEBIAN_OUTPUT): debian.control
	@echo "==> Creating meta-package $(DEBIAN_OUTPUT)"
	mkdir -p $(DEBIAN_OUTPUT_TMPDIR)/DEBIAN
	cp -pf debian.control $(DEBIAN_OUTPUT_TMPDIR)/DEBIAN/control
	dpkg-deb --build $(DEBIAN_OUTPUT_TMPDIR) $(DEBIAN_OUTPUT)
debian.control: debian.control.in debian.control.sh debian.list
	@echo "==> Generating $@"
	./debian.control.sh debian.control.in debian.list > "$@" || rm -f "$@"

freebsd: freebsd.makefile
freebsd.makefile: freebsd.list freebsd.ports
freebsd.ports: freebsd.list freebsd.ports.sh freebsd.ports.find
	@echo "==> Generating $@"
	./freebsd.ports.sh freebsd.list > "$@" || rm -f "$@"
freebsd.ports.find: freebsd.ports.find.c
	c99 -DHASH_TABLE_SIZE=50000 "$<" -o "$@"

clean:
	rm -f *.control *.makefile *.ports *.list
	rm -rf *.out
