#!/bin/sh

list_file="$1"
: "${list_file:="debian.list"}"

loop_first=1
while read -r pkg; do
	if [ "${loop_first}" = "1" ]; then
		printf '%s' "${pkg}"
	else
		printf ', %s' "${pkg}"
	fi
	loop_first=0
done < "${list_file}"
