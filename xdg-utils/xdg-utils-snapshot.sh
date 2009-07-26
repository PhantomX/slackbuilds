#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="anoncvs@anoncvs.freedesktop.org:/cvs/portland"

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
  cvs -z3 -d:pserver:${snaproot} co -d${module}-${snap} portland/${module}
  pushd ${module}-${snap}
    find . -type d -name CVS -print0 | xargs -0r rm -rf
  popd
  tar Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
