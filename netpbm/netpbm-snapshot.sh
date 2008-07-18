#!/bin/bash

set -e

module=netpbm
snaproot="https://netpbm.svn.sourceforge.net/svnroot/${module}/stable"
snaproot2="https://netpbm.svn.sourceforge.net/svnroot/${module}/userguide"

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
  svn checkout ${snaproot} ${module}-${snap}
  svn checkout ${snaproot2} ${module}-${snap}/userguide
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
