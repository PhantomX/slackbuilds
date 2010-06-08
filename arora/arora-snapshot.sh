#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="git://github.com/Arora/${module}.git"

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

[ "${snap}" = "$(date +%Y%m%d)" ] && SNAP_COOPTS="--depth 1"

pushd "${tmp}"
  git clone ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    if [ "${snap}" != "$(date +%Y%m%d)" ] ; then
      gitdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      git checkout $(git rev-list -n 1 --before="${gitdate}" master)
    fi
    # Set version
    GITVER="$(git log --pretty=format:%h | head -n1)"
    GITNUMBER="$(git log --pretty=format:%h | wc -l)"
    sed -i \
      -e "/^GITVERSION=/s|=.*|=${GITVER}|g" \
      -e "/^GITCHANGENUMBER=/s|=.*|=${GITNUMBER}|g" src/src.pri
    find . -type d -name .git -print0 | xargs -0r rm -rf
  popd
  tar Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
