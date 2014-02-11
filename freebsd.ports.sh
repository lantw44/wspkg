#!/bin/sh

msg () {
	echo "$@" 1>&2
}

get_origin () {
	grep "^$1" "${index}" | (
		IFS="${IFS}|"
		while read pkgnamever fullpath trash; do
			pkgname="${pkgnamever%-*}"
			if [ "${pkgname}" = "$1" ]; then
				this_origin="`echo "${fullpath}" | sed 's|^.*/\(.*/.*\)$|\1|'`"
				echo "${this_origin}"
				break
			fi
		done
	)
}

[ -z "$1" ] && msg "Usage: $0 list_file" && exit 1
: ${FREEBSD_VERSION:="`uname -r | sed 's|^\([0-9]*\).*$|\1|'`"}
: ${PORTSDIR:="/usr/ports"}
index="${PORTSDIR}/INDEX-${FREEBSD_VERSION}"

msg "==> FreeBSD version is ${FREEBSD_VERSION}"
msg "==> FreeBSD ports tree is ${PORTSDIR}"
msg "==> FreeBSD ports index file is ${index}"

exec 3< "$1"       # list file

echo "// vim: ft=c: et"
echo ""
echo "// ====================================================================="
echo "// This file maps FreeBSD packages to their ports directories"
echo "// ====================================================================="
echo ""

while read pkgname 0<&3; do
	msg "=> Processing package ${pkgname}"
	origin="`get_origin ${pkgname}`"
	[ -z "${origin}" ] && \
		msg "==> Cannot find origin for ${pkgname} in your index file" && \
		msg "==> Exit now!" && exit 1
	msg "=> Processing package ${pkgname} - ${origin}"
	printf "#define %-32s %s\n" "${pkgname}" "${origin}"
done

exec 3<&-

msg "==> Done!"
