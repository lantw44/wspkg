#!/bin/sh

msg_and_copy () {
	echo "==> Copying $1 to $2" 1>&2
	cp -r "$1" "$2"
}

msg_and_mkdir () {
	echo "==> Creating directory $1" 1>&2
	mkdir -p "$1"
}

: ${PORTSDIR:="/usr/ports"}
[ '!' -d "${PORTSDIR}/local" ] && \
	msg_and_mkdir "${PORTSDIR}/local"
[ '!' -f "${PORTSDIR}/local/Makefile" ] && \
	msg_and_copy "freebsd.local.Makefile" "${PORTSDIR}/local/Makefile"
[ '!' -f "${PORTSDIR}/local/Makefile.inc" ] && \
	msg_and_copy "freebsd.local.Makefile.inc" "${PORTSDIR}/local/Makefile.inc"

msg_and_copy "freebsd.out/217" "${PORTSDIR}/local"
