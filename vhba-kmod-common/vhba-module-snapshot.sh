#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="git://git.code.sf.net/p/cdemu/code"
tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}
snapbranch=${snapbranch:-master}
gittree=${gittree:-${snapbranch}}

[ "${snap}" = "$(date +%Y%m%d)" ] && SNAP_COOPTS="--depth 1"
[ "${snapbranch}" = "master" ] || snapbranch="origin/${snapbranch}"

pushd "${tmp}"
  git clone ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    if [ "${snap}" != "$(date +%Y%m%d)" ] && [ -z "${snaptag}" ] ; then
      gitdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      git checkout $(git rev-list -n 1 --before="${gitdate}" ${snapbranch})
      gittree=$(git reflog | grep 'HEAD@{0}' | awk '{print $1}')
    fi
    if [ -n "${snaptag}" ] ;then
      if git tag | grep -q ${snaptag} ;then
        gittree="${snaptag}"
      else
        echo "Tag not found! Printing available."
        git tag
        exit 1
      fi
    fi
    rm -rf cdemu-*/ gcdemu image-*/ libmirage/
    find . -type d -name .git -print0 | xargs -0r rm -rf
    rm -f .gitignore config.git-hash
    mv vhba-module/* .
    rmdir vhba-module
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
