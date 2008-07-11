#!/bin/bash

set -e

module=kdnssd-avahi
snaproot="svn://anonsvn.kde.org/home/kde/trunk/playground/network"

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
  svn --non-recursive checkout ${snaproot} ${module}-${snap}
  ## auto*/configure bits
  svn up ${module}-${snap}
  ## app
  svn export ${snaproot}/${module} ${module}-${snap}/${module}
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -r
    ln -s ${module} dnssd
  popd
  tar -jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
