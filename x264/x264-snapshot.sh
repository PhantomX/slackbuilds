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
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

pushd "${tmp}"
  git clone --depth 1 ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    git rev-list HEAD | sort > config.git-hash
    GITLOCALVER=$(wc -l config.git-hash | awk '{print $1}')
    GITVER=$(git rev-list origin/master | sort | join config.git-hash - | wc -l | awk '{print $1}')
    GITVER2="${GITVER} $(git rev-list HEAD -n 1 | head -c 7)"
    sed -i \
        -e '/^git-rev-list/d' \
        -e 's|git-status|git status|g' \
        -e "/^LOCALVER=/s|=.*$|=${GITLOCALVER}|g" \
        -e "/config.git-hash/s|VER=.*$|VER=${GITVER}|g" \
        -e "/HEAD/s|VER=.*$|VER=\"${GITVER2}\"|g" \
        ./version.sh
    find . -type d -name .git -print0 | xargs -0r rm -rf
    rm -f .gitignore config.git-hash
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
