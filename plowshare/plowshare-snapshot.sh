#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="http://${module}.googlecode.com/svn/trunk/"

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
    sed -i -e "/^DISTDIR =/s|=.*|= ${module}-${snap}|g" ./Makefile
    make distdir
    find . -type d -name .svn -print0 | xargs -0r rm -rf
    tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
  popd
popd >/dev/null

