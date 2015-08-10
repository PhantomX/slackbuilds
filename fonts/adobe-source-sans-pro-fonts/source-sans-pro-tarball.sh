#!/bin/bash

set -e

if [ -z "${tag}" ] ;then
  echo "Need tag variable exported before!"
  exit 1
fi

module=$(basename $0 -tarball.sh)
snaproot="https://github.com/adobe-fonts/${module}/tags/${tag}"
srcdir=${module}-${VERSION}

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)

pushd "${tmp}"
  svn export --depth=files --force ${snaproot} ${srcdir}
  svn export ${snaproot}/OTF ${srcdir}/OTF
  pushd ${srcdir}
    rm -f */*.zip
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${srcdir}.tar.xz ${srcdir}
popd >/dev/null

