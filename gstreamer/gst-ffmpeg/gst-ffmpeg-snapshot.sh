#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
    set +e
    [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
cvs=${cvs:-$(date +%Y%m%d)}

pushd "${tmp}"
  cvs -d:pserver:anoncvs@anoncvs.freedesktop.org:/cvs/gstreamer co -d${module}-${cvs} ${module}
  pushd ${module}-${cvs}
    find . -type d -name CVS -print0 | xargs -0r rm -rf
  popd
  tar Jcf "${pwd}"/${module}-${cvs}.tar.xz ${module}-${cvs}
popd >/dev/null
