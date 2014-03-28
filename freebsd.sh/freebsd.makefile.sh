#!/bin/sh

gen_list () {
	exec 4< "${ports_file}"

	while read -r pkg_name pkg_ports 0<&4; do
		echo "    ${pkg_name}>=0:"'${PORTSDIR}'"/${pkg_ports} \\"
	done

	exec 4<&-
}

makefile_in_file="$1"
: ${makefile_in_file:="freebsd.makefile.in"}

ports_file="$2"
: ${ports_file:="freebsd.ports"}

exec 3< "${makefile_in_file}"

saveIFS="${IFS}"
lineIFS="$(printf "\n")"
IFS="${lineIFS}"

while read -r makefile_line 0<&3; do
	case "${makefile_line}" in
		"PORTVERSION="*)
			printf "PORTVERSION=\t%s\n" "`date '+%Y.%m.%d'`"
			;;
		"RUN_DEPENDS+="*)
			echo 'RUN_DEPENDS+= \'
			IFS="${saveIFS}"
			gen_list
			IFS="${lineIFS}"
			;;
		*)
			echo "${makefile_line}"
			;;
	esac
done

exec 3<&-
