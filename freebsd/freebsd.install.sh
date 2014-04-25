#!/bin/sh

msg_and_copy () {
    echo "==> Copying $1 to $2" 1>&2
    cp -r "$1" "$2"
}

msg_and_mkdir () {
    echo "==> Creating directory $1" 1>&2
    mkdir -p "$1"
}

if [ -z "$4" ]; then
    echo "Usage: $0 category cat_makefile cat_makefile_inc dir"
    echo "Example: "'`'"$0 local local.makefile local.makefile.inc 217' will do"
    echo " mkdir -p                 /usr/ports/local"
    echo " cp -r local.makefile     /usr/ports/local/Makefile"
    echo " cp -r local.makefile.inc /usr/ports/local/Makefile.inc"
    echo " cp -r 217                /usr/ports/local"
    exit 1
fi

: ${PORTSDIR:="/usr/ports"}
category="$1"
cat_makefile="$2"
cat_makefile_inc="$3"
dir="$4"

[ '!' -d "${PORTSDIR}/${category}" ] && \
    msg_and_mkdir "${PORTSDIR}/${category}"
[ '!' -f "${PORTSDIR}/${category}/Makefile" ] && \
    msg_and_copy "${cat_makefile}" "${PORTSDIR}/${category}/Makefile"
[ '!' -f "${PORTSDIR}/${category}/Makefile.inc" ] && \
    msg_and_copy "${cat_makefile_inc}" "${PORTSDIR}/${category}/Makefile.inc"

msg_and_copy "${dir}" "${PORTSDIR}/${category}"
