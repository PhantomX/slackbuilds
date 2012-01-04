#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="http://svn.softwarepublico.gov.br/svn/${module}/trunk/latest"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
unset SNAP_USER
unset SNAP_COOPTS
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r {$snap}"

echo -n "Insert ${module} repository username: "
read SNAP_USER

if [ -z "${SNAP_USER}" ] ;then
  echo "Empty username"
  exit 1
fi

pushd "${tmp}"
  svn export --username ${SNAP_USER} ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  svn co --depth=files --force --username ${SNAP_USER} ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    SVNREV="$(LC_ALL=C svn info 2> /dev/null | grep '^Revision' | cut -d' ' -f2)"
    SVNLCD="$(LC_ALL=C svn info 2> /dev/null | grep '^Last Changed Date:' | cut -d' ' -f4,5 )"
    PACKAGE_RELEASE="$( grep ^PACKAGE_RELEASE= bootstrap.sh |cut -d= -f2 )"
    REV_FILE=revision.m4
    echo "m4_define([SVN_REV], ${SVNREV})" > ${REV_FILE}
    echo "m4_define([SVN_DATE], ${SVNLCD})" >> ${REV_FILE}
    echo "m4_define([SVN_RELEASE], ${PACKAGE_RELEASE})" >> ${REV_FILE}
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
