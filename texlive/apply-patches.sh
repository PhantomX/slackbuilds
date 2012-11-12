#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tl-kpfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/texlive-stdc++11.patch
patch -p2 -E --backup --verbose -d source/libs/icu/icu-${SB_ICUVER} -i ${SB_PATCHDIR}/icu-50.1-no-c++11.patch

set +e +o pipefail
