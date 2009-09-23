#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="https://opentyrian.googlecode.com/hg"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r {$snap}"

pushd "${tmp}"
  hg clone ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    HG_REV=$(hg id -ib && touch src/hg_revision.h)
    sed -i -e "/^HG_REV/s|:=.*|:= ${HG_REV}|g" Makefile
    find . -type d -name .git -print0 | xargs -0r rm -rf
    rm -f .hgignore
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
