#!/bin/sh

msg () {
	echo "$@" 1>&2
}

[ -z "$1" ] && msg "Usage: $0 list_file" && exit 1
: ${FREEBSD_VERSION:="`uname -r | sed 's|^\([0-9]*\).*$|\1|'`"}
: ${PORTSDIR:="/usr/ports"}
index="${PORTSDIR}/INDEX-${FREEBSD_VERSION}"

msg "==> FreeBSD version is ${FREEBSD_VERSION}"
msg "==> FreeBSD ports tree is ${PORTSDIR}"
msg "==> FreeBSD ports index file is ${index}"

msg "==> Running freebsd.ports.find"
if ./freebsd.ports.find "$1" "${index}"; then
	msg "==> Done!"
else
	msg "==> Failed"
	exit 1
fi
