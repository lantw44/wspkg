#!/bin/sh

list_file="$1"
: ${list_file:="arch.list"}

loop_first=1
for pkg in `cat "${list_file}"`; do
	if [ "${loop_first}" = "1" ]; then
		printf "'%s'" "${pkg}"
	else
		printf " '%s'" "${pkg}"
	fi
	loop_first=0
done
