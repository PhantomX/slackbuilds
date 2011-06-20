
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Make sure we don't use bundled libvpx headers.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-vpx-r4.patch
# gcc 4.6 - http://code.google.com/p/chromium/issues/detail?id=70746
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc46-p1.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc46-p2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc46-backport.patch

set +e +o pipefail
