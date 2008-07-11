#!/bin/sh

set -e

module=drivel

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
  cvs -d:pserver:anonymous@anoncvs.gnome.org:/cvs/gnome login
  cvs -z3 -d:pserver:anonymous@anoncvs.gnome.org:/cvs/gnome co -d${module}-${snap} ${module}
  pushd ${module}-${snap}
    find . -type d -name CVS -print0 | xargs -0r rm -rf
  popd
  tar jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
