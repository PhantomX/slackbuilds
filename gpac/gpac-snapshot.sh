#!/bin/bash

set -e

module=gpac

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
    set +e
    [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
cvs=$(date +%Y%m%d)

pushd "${tmp}"
cvs -d:pserver:anonymous@gpac.cvs.sourceforge.net:/cvsroot/${module} login
cvs -z3 -d:pserver:anonymous@gpac.cvs.sourceforge.net:/cvsroot/${module} co -d${module}-${cvs} -P ${module}
pushd ${module}-${cvs}
find . -type d -name CVS -print0 | xargs -0r rm -rf
popd
tar jcf "${pwd}"/${module}-${cvs}.tar.bz2 ${module}-${cvs}
popd >/dev/null
