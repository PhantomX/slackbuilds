#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tl-kpfix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tl-testfix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tl-format.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-system-teckit.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-bz979176.patch

set +e +o pipefail
