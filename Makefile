.POSIX:
.PHONY: all clean debian freebsd
.SUFFIXES: .pkg .list

all: debian freebsd

.pkg.list: packages.h packages.sh
	@echo "==> Generating list file $@"
	./packages.sh `echo "$<" | cut -d . -f 1` | sort | uniq > "$@" || rm -f "$@"

debian: debian.control
debian.control: debian.list

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
