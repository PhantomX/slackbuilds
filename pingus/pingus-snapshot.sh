#!/bin/bash

set -e

module=pingus
snaproot="svn://svn.berlios.de/${module}/branches/${module}_sdl"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
svn=${svn:-$(date +%Y%m%d)}

pushd "${tmp}"
  svn checkout -r {$svn} ${snaproot} ${module}-${svn}
  pushd ${module}-${svn}
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
tar jcf "${pwd}"/${module}-${svn}.tar.bz2 ${module}-${svn}
popd >/dev/null
