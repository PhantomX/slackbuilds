#!/bin/bash

set -e

module=kde-autoconf
snaproot="svn://anonsvn.kde.org/home/kde/branches/KDE/3.3/kde-common/admin"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

pushd "${tmp}"
  mkdir ${module}-${snap}
  svn --non-recursive checkout ${snaproot} ${module}-${snap}/admin
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -r
    mv admin ../ 
  popd
  rm -rf ${module}-${snap}
  tar -jcf "${pwd}"/${module}-${snap}.tar.bz2 admin
popd >/dev/null
