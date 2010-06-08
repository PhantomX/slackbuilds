#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="http://dolphin-emu.googlecode.com/svn/trunk"

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
    svn export ${SNAP_COOPTS} ${snaproot}/Source
    svn export ${SNAP_COOPTS} ${snaproot}/Data
    svn export ${SNAP_COOPTS} ${snaproot}/SconsTests
    svn export ${SNAP_COOPTS} ${snaproot}/docs
    mkdir Externals
    pushd Externals
      svn export ${SNAP_COOPTS} ${snaproot}/Externals/Bochs_disasm
      svn export ${SNAP_COOPTS} ${snaproot}/Externals/Lua
    popd >/dev/null
    SVNREV="$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)"
    sed -i -e "/SVN_REV_STR/s|\".*\"|\"${SVNREV}\"|g" Source/Core/Common/Src/svnrev_template.h
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
