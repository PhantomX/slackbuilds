#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="anoncvs@anoncvs.freedesktop.org:/cvs/gstreamer"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-D${snap}"

pushd "${tmp}"
  cvs -d:pserver:${snaproot} co ${SNAP_COOPTS} -d${module}-${snap} ${module}
  pushd ${module}-${snap}
    find . -type d -name CVS -print0 | xargs -0r rm -rf
  popd
  tar Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
