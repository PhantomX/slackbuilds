#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="svn://svn.mplayerhq.hu/dvdnav/trunk/${module}"

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
    # Force revision number
    SVNREV="$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)"
    sed -i -e "/^svn_revision=/s|=.*|=${SVNREV}|g" ./version.sh
    find . -type d -name .svn -print0 | xargs -0r rm -rf
    sed -i -e '/^\.PHONY: version\.h$/d' Makefile
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
