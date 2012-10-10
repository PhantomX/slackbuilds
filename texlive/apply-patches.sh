#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tl-kpfix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/texlive-badtest.patch

set +e +o pipefail
