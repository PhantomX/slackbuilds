#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="https://git01.codeplex.com/${module}"

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

#[ "${snap}" = "$(date +%Y%m%d)" ] && SNAP_COOPTS="--depth 1"
[ "${snapbranch}" = "master" ] || snapbranch="origin/${snapbranch}"

pushd "${tmp}"
  git clone ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    if [ "${snap}" != "$(date +%Y%m%d)" ] && [ -z "${snaptag}" ] ; then
      gitdate="$(echo -n ${snap} | head -c -4)-$(echo -n ${snap} | tail -c -4|head -c -2)-$(echo -n ${snap} | tail -c -2)"
      git checkout $(git rev-list -n 1 --before="${gitdate}" ${snapbranch})
      gittree=$(git reflog | grep 'HEAD@{0}' | awk '{print $1}')
    fi
    if [ "${snapbranch}" != "master" ] && [ -z "${snaptag}" ];then
      git checkout -q ${gittree}
    fi
    if [ -n "${snaptag}" ] ;then
      if git tag | grep -q ${snaptag} ;then
        git checkout ${snaptag}
      else
        echo "Tag not found! Printing available."
        git tag
        exit 1
      fi
    fi
    GITREV="$(LC_ALL=C git rev-list --count HEAD).$(LC_ALL=C git rev-parse --short HEAD)"
    rm -f ${module}/.git*
    mv ${module}/* .
    rmdir ${module}
    rm -rf win32 macosx
    sed -i 's/\r//' gui/AboutDlg.c
    sed -i -e "/^#define ABOUT_VERSION/s|\"git\"$|\"git-r${GITREV}\"|g" gui/AboutDlg.c
    find . -type d -name .git -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
