#!/bin/sh

ports_file="$1"
: ${ports_file:="freebsd.ports"}

exec 4< "${ports_file}"

while read -r pkg_name pkg_ports pkg_flavor 0<&4; do
	if [ "${pkg_flavor}" != "@" ]; then
		pkg_ports="${pkg_ports}@${pkg_flavor}"
	fi
	printf "    %s>=a:%s ^%%" "${pkg_name}" "${pkg_ports}"
done

exec 4<&-
