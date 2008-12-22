#!/bin/bash

set -e

module=libnut
snaproot="svn://svn.mplayerhq.hu/nut"

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
  svn checkout -r {$snap} ${snaproot}/src/trunk ${module}-${snap}
  svn checkout -r {$snap} ${snaproot}/docs ${module}-${snap}/docs
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
