#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="git://linuxconsole.git.sourceforge.net/gitroot/linuxconsole/linuxconsole"

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
    if [ "${snap}" != "$(date +%Y%m%d)" ] && [ -z "${tag}" ] ; then
      gitdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      git checkout $(git rev-list -n 1 --before="${gitdate}" ${gitbranch})
    fi
    if [ -n "${tag}" ] ;then
      if git tag | grep -q ${tag} ;then
        git checkout ${tag}
      else
        echo "Tag not found! Printing available."
        git tag
        exit 1
      fi
    fi
    mkdir ../remove
    rm -f docs/FB-Driver-HOWTO docs/console.txt
    mv * ../remove/
    mv ../remove/{docs,utils,COPYING,Makefile,NEWS,README} .
    find . -type d -name .git -print0 | xargs -0r rm -rf
    rm -f .gitignore config.git-hash
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
