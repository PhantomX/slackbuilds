#!/bin/sh

set -e

module=$(basename $0 -snapshot.sh)
snaproot="https://${module}.svn.sourceforge.net/svnroot/${module}/trunk"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r {$snap}"

pushd "${tmp}"
  svn checkout ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
