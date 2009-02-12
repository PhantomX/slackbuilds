#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="http://atheme.org/audacious/${module}"

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
    find . -type d -name .hig -print0 | xargs -0r rm -rf
    rm -f .hgignore .hgtags
  popd
  tar -jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
