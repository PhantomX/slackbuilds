#!/bin/bash

set -e

module=xfburn
snaproot="http://svn.xfce.org/svn/goodies/${module}/trunk"

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
  svn checkout -r {$snap} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    # Fix svn revision
    SVNREV="$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)"
    sed -i -e "/^revision=/s|=.*$|=${SVNREV}|g" autogen.sh
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
