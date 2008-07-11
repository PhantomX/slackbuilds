#!/bin/bash

set -e

module=drm

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
  git clone git://anongit.freedesktop.org/git/mesa/drm/ ${module}-${snap}
  pushd ${module}-${svn}
    #./version.sh .
    find . -type d -name .svn -print0 | xargs -0r rm -rf
    #sed -i -e '/^\.PHONY: version\.h$/d' Makefile
  popd
  tar jcf "${pwd}"/${module}-${svn}.tar.bz2 ${module}-${svn}
popd >/dev/null
