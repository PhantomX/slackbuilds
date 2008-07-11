#!/bin/bash

set -e

module=gens
snaproot=":pserver:anonymous@gens.cvs.sourceforge.net:/cvsroot/${module}"

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
  echo | cvs -d${snaproot} login
  cvs -z3 -d${snaproot} co -d${module}-${snap} -P Gens-MultiPlatform
  pushd ${module}-${snap}
    find . -type d -name CVS -print0 | xargs -0r rm -rf
  popd
  tar jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
