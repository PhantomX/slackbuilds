#!/bin/bash

DATE=$(date +%Y%m%d)
EXPORT_DIR=qt-copy
snaproot="svn://anonsvn.kde.org/home/kde/trunk/${EXPORT_DIR}"

set -x

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
  # app
  svn export --non-recursive ${snaproot} ${EXPORT_DIR}/
  svn export ${snaproot}/patches ${EXPORT_DIR}/patches

  pushd ${EXPORT_DIR}
    tar -cjf "${pwd}"/qt-copy-patches-${DATE}.tar.bz2 \
      .applied_patches apply_patches README.qt-copy patches/ 
  popd
popd >/dev/null
