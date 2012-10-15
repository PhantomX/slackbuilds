#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="http://pcsx2.googlecode.com/svn/trunk"

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
    svn export ${SNAP_COOPTS} ${snaproot}/bin
    svn export ${SNAP_COOPTS} ${snaproot}/cmake
    svn export ${SNAP_COOPTS} ${snaproot}/common
    svn export ${SNAP_COOPTS} ${snaproot}/fps2bios
    svn export ${SNAP_COOPTS} ${snaproot}/linux_various
    svn export ${SNAP_COOPTS} ${snaproot}/locales
    svn export ${SNAP_COOPTS} ${snaproot}/nsis
    svn export ${SNAP_COOPTS} ${snaproot}/pcsx2
    svn export ${SNAP_COOPTS} ${snaproot}/plugins
    svn export ${SNAP_COOPTS} ${snaproot}/tools
    svn co --depth=files --force ${SNAP_COOPTS} ${snaproot}/3rdparty
    pushd "${pwd}/${module}/3rdparty"
      svn export ${SNAP_COOPTS} ${snaproot}/3rdparty/tinyxml
    popd >/dev/null
    SVNREV="$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)"
    sed -i \
      -e "/SVN_REV/s|\${tmpvar_WC_REVISION}|${SVNREV}|g" \
      -e "/SVN_REV/s|SVN_REV 0|SVN_REV ${SVNREV}|g" \
      pcsx2/CMakeLists.txt
    # Force revision number
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
