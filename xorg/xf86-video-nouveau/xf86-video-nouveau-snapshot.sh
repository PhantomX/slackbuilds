#!/bin/bash

set -e

module=xf86-video-nouveau
snaproot="git://git.freedesktop.org/git/nouveau/${module}"

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
gittree=master

[ "${snap}" = "$(date +%Y%m%d)" ] && SNAP_COOPTS="--depth 1"

pushd "${tmp}"
  git clone ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    if [ "${snap}" != "$(date +%Y%m%d)" ] ; then
      gitdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      git checkout $(git rev-list -n 1 --before="${gitdate}" master)
      gittree=$(git reflog | grep 'HEAD@{0}' | awk '{print $1}')
    fi
    git archive --format=tar --prefix=${module}-${snap}/ ${gittree} | xz -9 > "${pwd}"/${module}-${snap}.tar.xz
  popd
popd >/dev/null
