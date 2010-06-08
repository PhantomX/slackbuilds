#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot=":pserver:anonymous@gens.cvs.sourceforge.net:/cvsroot/${module}"

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

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-D${snap}"

pushd "${tmp}"
  echo | cvs -d${snaproot} login
  cvs -z3 -d${snaproot} co ${SNAP_COOPTS} -d${module}-${snap} -P Gens-MultiPlatform
  pushd ${module}-${snap}
    find . -type d -name CVS -print0 | xargs -0r rm -rf
  popd
  tar Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
