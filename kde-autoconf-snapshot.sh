#!/bin/bash

set -e

module=kde-autoconf
snaproot="svn://anonsvn.kde.org/home/kde/branches/KDE/3.5/kde-common/admin"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
unset SNAP_COOPTS
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r {$snap}"

pushd "${tmp}"
  svn export ${SNAP_COOPTS} ${snaproot} admin
  find . -type d -name .svn -print0 | xargs -0r rm -r
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz admin
popd >/dev/null
