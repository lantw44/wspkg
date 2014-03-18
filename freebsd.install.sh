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
if [ '!' -d "${PORTSDIR}/local" ]; then
	msg_and_mkdir "${PORTSDIR}/local"

	echo "=> Generating ${PORTSDIR}/local/Makefile" 2>&1
	cat << EOF > "${PORTSDIR}/local/Makefile"
# \$FreeBSD\$
#

    COMMENT = Local ports

    SUBDIR += 217

.include <bsd.port.subdir.mk>
EOF

	echo "=> Generating ${PORTSDIR}/local/Makefile.inc" 2>&1
	cat << EOF > "${PORTSDIR}/local/Makefile.inc"
# $FreeBSD$
#

PKGNAMEPREFIX?=	local-

# Make sure we have the correct origin registered
PKGCATEGORY=	local
EOF

fi

msg_and_copy "freebsd.out/217" "${PORTSDIR}/local"
