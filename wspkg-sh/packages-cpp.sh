#!/bin/sh

toupper () {
    printf '%s\n' "$1" | sed 's/^-//' | tr '[:lower:]' '[:upper:]'
}

[ -z "$1" ] && printf 'Usage: %s input_file cpp_args\n' "$0" && exit 1

# shellcheck disable=SC2034
input_file="$1"
shift

: "${CPP:="cpp"}"
: "${CPPFLAGS:="-I."}"
while [ "$1" ]; do
    case "$1" in
        -*)
            selarg="$selarg -D$(toupper "$1")"
            ;;
        *)
            selarg="$selarg -DWSPKG_$(toupper "$1")"
            ;;
    esac
    shift
done

eval "${CPP} ${CPPFLAGS} $selarg "'"$input_file"' | \
    sed -e '/^#/d' -e '/^ *$/d' | tr ' ' '\n' | sed '/^ *$/d'
