#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="https://vbam.svn.sourceforge.net/svnroot/${module}/trunk"
snaproot2="https://vbam.svn.sourceforge.net/svnroot/${module}/dependencies"

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

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r {$snap}"

pushd "${tmp}"
  svn export ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  svn co --depth=files --force ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    SVNREV="$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)"
    sed -i -e "/VERSION/s|-SVN|\0-r${SVNREV}|g" CMakeLists.txt
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
