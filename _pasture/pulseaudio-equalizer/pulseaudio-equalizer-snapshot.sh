#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="lp:~psyke83/+junk/${module}"

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

bzrdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r date:${bzrdate}"

pushd "${tmp}"
  mkdir ${module}-${snap}
  bzr checkout --lightweight ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    find . -type d -name .bzr -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
