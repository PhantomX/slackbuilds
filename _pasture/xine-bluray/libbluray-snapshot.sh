#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="git://git.videolan.org/${module}.git"

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
gitbranch=${gitbranch:-master}
gittree=${gittree:-${gitbranch}}

[ "${snap}" = "$(date +%Y%m%d)" ] && SNAP_COOPTS="--depth 1"
[ "${gitbranch}" = "${master}" ] || gitbranch="origin/${gitbranch}"

pushd "${tmp}"
  git clone ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    if [ "${snap}" != "$(date +%Y%m%d)" ] ; then
      gitdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      git checkout $(git rev-list -n 1 --before="${gitdate}" ${gitbranch})
    fi
    git archive --format=tar --prefix=${module}-${snap}/ ${gittree} | xz -9 > "${pwd}"/${module}-${snap}.tar.xz
  popd
popd >/dev/null
