
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Make sure we don't use bundled libvpx headers.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-vpx-r4.patch

set +e +o pipefail
