#!/bin/bash

set -e

if [ -z "${snap}" ] ; then
  echo "Missing tag version"
  exit 1
fi

module=$(basename $0 -snapshot.sh)
snaproot="https://vdrift.svn.sourceforge.net/svnroot/vdrift/tags/${module}-${snap}"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)

pushd "${tmp}"
  svn export ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
