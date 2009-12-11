#!/bin/bash

set -e

module=$(basename $0 .sh)
snaproot="http://hg.debian.org/hg/${module}/xine-lib"

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
  hg clone ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    if [ "${snap}" != "$(date +%Y%m%d)" ] ; then
      hgdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      hg checkout -d "${hgdate}"
    fi
    find . -type d -name .hig -print0 | xargs -0r rm -rf
    rm -f .hgignore .hgsigs .hgtags
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
