#!/bin/sh

ports_file="$1"
: ${ports_file:="freebsd.ports"}

tr '/' '_' < "${ports_file}" | paste "${ports_file}" - | (
	while read -r pkg_name pkg_ports unused pkg_ports_var; do
		printf '    ${WSPKG_PACKAGE_NAME_%s}>=0:${PORTSDIR}/%s ^%%' \
			"${pkg_ports_var}" "${pkg_ports}"
	done )
