#!/bin/sh

msg () {
	echo "$@" 1>&2
}

list_file="$1"
: ${list_file:="arch.list"}
: ${TAR:="tar"}
: ${ARCH_DBPATH:="/var/lib/pacman"}
dbpath_sync="${ARCH_DBPATH}/sync"

newline='
'
pkg_groups_map=''
pkg_groups_prev=''

# pkg_groups_add <package> <group>
pkg_groups_add () {
	if [ "$1" = "${pkg_groups_prev}" ]; then
		pkg_groups_map="${pkg_groups_map}/$2/"
	else
		pkg_groups_map="${pkg_groups_map}${newline}$1 /$2/"
	fi
	pkg_groups_prev="$1"
}

# pkg_groups_find <group>
pkg_groups_find () {
	echo "${pkg_groups_map}" | grep "/$1/" | cut -f 1 -d ' '
}

# Build the list of groups
for db in "${dbpath_sync}"/*.db; do
	msg "==> Loading package database ${db}"
	tmpdir="`mktemp -d`"
	if [ -z "${tmpdir}" ] || [ "`dirname "${tmpdir}"`" = "/" ]; then
		msg "==> Invalid temporary directory ${tmpdir}"
		exit 1
	fi
	${TAR} -xf "${db}" -C "${tmpdir}"
	for desc in "${tmpdir}"/*/desc; do
		have_groups=0
		case "`cat "${desc}"`" in
			*%GROUPS%*)
				have_groups=1
				;;
		esac
		if [ "${have_groups}" = "0" ]; then
			continue
		fi
		name=''
		name_next=0
		groups_found=0
		while read -r oneline; do
			case "${oneline}" in
				%GROUPS%)
					groups_found=1
					continue
					;;
				%NAME%)
					if [ "${name_next}" = "0" ]; then
						name_next=1
						continue
					fi
					;;
				%*%)
					if [ "${groups_found}" = "1" ]; then
						break
					fi
					;;
			esac
			if [ "${name_next}" = "1" ]; then
				name="${oneline}"
				name_next=2
				continue
			fi
			if [ "${groups_found}" = "1" ]; then
				if [ "${name_next}" != "2" ]; then
					msg "==> %GROUPS% found before %NAME%"
					exit 1
				fi
				if [ -z "${oneline}" ]; then
					continue
				fi
				pkg_groups_add "${name}" "${oneline}"
			fi
		done < "${desc}"
	done
	rm -rf "${tmpdir}"
done

loop_first=1
msg "==> Expanding all groups"
for pkg_or_group in `cat "${list_file}"`; do
	pkgs="`pkg_groups_find "${pkg_or_group}"`"
	if [ -z "${pkgs}" ]; then
		pkgs="${pkg_or_group}"
	fi
	for pkg in ${pkgs}; do
		if [ "${loop_first}" = "1" ]; then
			printf "'%s'" "${pkg}"
		else
			printf " '%s'" "${pkg}"
		fi
		loop_first=0
	done
done
