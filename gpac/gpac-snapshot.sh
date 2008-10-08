#!/bin/bash

set -e

module=gpac
snaproot="anonymous@gpac.cvs.sourceforge.net:/cvsroot/${module}"

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
  cvs -d:pserver:${snaproot} login
  cvs -z3 -d:pserver:${snaproot} co -d${module}-${cvs} -P ${module}
  pushd ${module}-${cvs}
    find . -type d -name CVS -print0 | xargs -0r rm -rf
  popd
  tar jcf "${pwd}"/${module}-${cvs}.tar.bz2 ${module}-${cvs}
popd >/dev/null
