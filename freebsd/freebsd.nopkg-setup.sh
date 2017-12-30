#!/bin/sh

ports_file="$1"
: ${ports_file:="freebsd.ports"}

count=`wc -l < "${ports_file}"`
tr '/' '_' < "${ports_file}" | paste "${ports_file}" - | (
	index=1
	while read -r pkg_name pkg_ports pkg_flavor unused pkg_ports_var unused; do
		if [ "${pkg_flavor}" != "@" ]; then
			pkg_ports_var="${pkg_ports_var}_${pkg_flavor}"
			pkg_ports="${pkg_ports} FLAVOR=${pkg_flavor}"
		fi
		printf 'WSPKG_PACKAGE_NAME_%-40s != printf "\\\\r===> Generating package names (%5d/%5d)" 1>\\&2; $(MAKE) -C ${PORTSDIR}/%-48s -V PKGNAMEPREFIX -V PORTNAME -V PKGNAMESUFFIX \\| tr -d "\\\\n"%%' \
			"${pkg_ports_var}" "${index}" "${count}" "${pkg_ports}"
		index=$(( ${index} + 1 ))
	done )
printf 'WSPKG_PACKAGE_NAME_%-25s != echo 1>\\&2; echo %%' "NULL"
