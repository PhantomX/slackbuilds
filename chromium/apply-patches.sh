
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Enable optional support for gecko-mediaplayer.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gecko-mediaplayer-r1.patch
# Make sure we don't use bundled libvpx headers.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-vpx-r2.patch
# Make sure we don't use bundled FLAC.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-flac-r0.patch

set +e +o pipefail
