#!/bin/sh

toupper () {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

[ -z "${CPP}" ] && CPP="cpp"
[ -z "$1" ] && echo "Usage: $0 os_type cpp_args" && exit 1
[ -z "$2" ] && default="yes"

ostype="`toupper "$1"`"
shift

if [ "$default" = "yes" ]; then
    selarg="-UWSPKG_NO_DEFAULT "
else
    selarg="-DWSPKG_NO_DEFAULT "
    while [ "$1" ]; do
        selarg="$selarg -DWSPKG_`toupper "$1"`"
        shift
    done
fi

${CPP} -D"$ostype" $selarg packages.h | \
    sed -e '/^#/d' -e '/^ *$/d' | tr ' ' '\n' | sed '/^ *$/d'
