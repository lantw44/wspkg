#!/bin/sh

ports_file="$1"
: ${ports_file:="freebsd.ports"}

tr '/' '_' < "${ports_file}" | paste "${ports_file}" - | (
	while read -r pkg_name pkg_ports pkg_flavor unused pkg_ports_var unused; do
		if [ "${pkg_flavor}" != "@" ]; then
			pkg_ports_var="${pkg_ports_var}_${pkg_flavor}"
			pkg_ports="${pkg_ports}@${pkg_flavor}"
		fi
		printf '    ${WSPKG_PACKAGE_NAME_%s}>=a:%s ^%%' \
			"${pkg_ports_var}" "${pkg_ports}"
	done )
