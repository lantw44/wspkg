#!/bin/sh

gen_list () {
	loop_first=1
	for pkg in `cat "${list_file}"`; do
		if [ "${loop_first}" = "1" ]; then
			printf "%s" "${pkg}"
		else
			printf ", %s" "${pkg}"
		fi
		loop_first=0
	done
}

control_in_file="$1"
: ${control_in_file:="debian.control.in"}

list_file="$2"
: ${list_file:="debian.list"}

exec 3< "${control_in_file}"

saveIFS="${IFS}"
lineIFS="$(printf "\n")"
IFS="${lineIFS}"

while read -r control_line 0<&3; do
	case "${control_line}" in
		"Version:"*)
			printf "Version: %s\n" "`date '+%Y.%m.%d'`"
			;;
		"Depends:"*)
			printf "Depends: "
			IFS="${saveIFS}"
			gen_list
			IFS="${lineIFS}"
			printf "\n"
			;;
		*)
			echo "${control_line}"
			;;
	esac
done

exec 3<&-
