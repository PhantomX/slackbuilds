#!/bin/bash

EXPORT_DIR=qt-copy
snaproot="svn://anonsvn.kde.org/home/kde/branches/qt/3.3/${EXPORT_DIR}"

set -e -x

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

pushd "${tmp}"
  # app
  svn export --non-recursive ${snaproot} ${EXPORT_DIR}/
  svn export ${snaproot}/patches ${EXPORT_DIR}/patches

  pushd ${EXPORT_DIR}
    tar -cJf "${pwd}"/qt3-copy-patches-${snap}.tar.xz \
      .applied_patches apply_patches README.qt-copy patches/ 
  popd
popd >/dev/null
