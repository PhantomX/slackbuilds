#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="http://svn.netlabs.org/repos/${module}/trunk"

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
  svn checkout --depth=files --force ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    svn export ${SNAP_COOPTS} ${snaproot}/dist
    svn export ${SNAP_COOPTS} ${snaproot}/src
    svn export ${SNAP_COOPTS} ${snaproot}/tests
    svn export --depth=files --force ${SNAP_COOPTS} ${snaproot}/kBuild
    pushd kBuild
      for dir in doc msgstyles sdks templates tools units ;do
        svn export ${SNAP_COOPTS} ${snaproot}/kBuild/${dir}
      done
    popd >/dev/null
    SVNREV="$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)"
    echo "KBUILD_SVN_URL := ${snaproot}" > SvnInfo.kmk
    echo "KBUILD_SVN_REV := ${SVNREV}" >> SvnInfo.kmk
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
