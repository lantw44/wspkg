#!/bin/sh

ports_file="$1"
: "${ports_file:="freebsd.ports"}"

# shellcheck disable=SC2094
tr '/' '_' < "${ports_file}" | paste -- "${ports_file}" - | (
	while read -r _ pkg_ports pkg_flavor _ pkg_ports_var _; do
		if [ "${pkg_flavor}" != "@" ]; then
			pkg_ports_var="${pkg_ports_var}_${pkg_flavor}"
			pkg_ports="${pkg_ports}@${pkg_flavor}"
		fi
		# shellcheck disable=SC2016
		printf '    ${WSPKG_PACKAGE_NAME_%s}>=a:%s ^%%' \
			"${pkg_ports_var}" "${pkg_ports}"
	done )
