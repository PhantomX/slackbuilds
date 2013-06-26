#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="http://electricsheep.googlecode.com/svn/trunk/client_generic"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
unset SNAP_COOPTS
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r {$snap}"

pushd "${tmp}"
  svn co --depth=files --force ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    for dir in \
      Client Common ContentDecoder ContentDownloader DisplayOutput MSVC Networking \
      Runtime TupleStorage lua5.1 menu-entries mk tinyXml
    do
      svn export ${SNAP_COOPTS} ${snaproot}/${dir}
    done
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
