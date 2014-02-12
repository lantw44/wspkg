.POSIX:
.PHONY: all clean debian freebsd
.SUFFIXES: .pkg .list

all: debian freebsd

.pkg.list: packages.h
	@echo "==> Generating list file $@"
	./packages.sh `echo "$<" | cut -d . -f 1` | sort | uniq > "$@" || rm -f "$@"

debian: debian.control
debian.control: debian.list

freebsd: freebsd.makefile
freebsd.makefile: freebsd.list freebsd.ports
freebsd.ports: freebsd.list
	@echo "==> Generating $@"
	./freebsd.ports.sh freebsd.list > "$@" || rm -f "$@"

clean:
	rm -f *.control *.makefile *.ports *.list
	rm -rf *.out
