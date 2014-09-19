#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="http://opensvn.wiimm.de/wii/trunk/${module}"

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
    # Force revision number
    SVNREV="$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)"
    sed -i -e "/^revision=/s|=.*|=${SVNREV}|g" ./setup.sh
    if which svnversion >/dev/null 2>&1 ; then
      SVNREVV="$(LC_ALL=C svnversion|sed 's/.*://')"
      (( ${SVNREV//[!0-9]/} < ${SVNREVV//[!0-9]/} )) && SVNREV=${SVNREVV}
    fi
    SVNREV="${SVNREV//[!0-9]/}"
    sed -i -e "/^revision_num=/s|=.*|=${SVNREV}|g" ./setup.sh
    find . -type d -name .svn -print0 | xargs -0r rm -rf
    sed -i -e '/^\.PHONY: version\.h$/d' Makefile
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
