
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libextractor-ffmpeg2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libextractor-giflib51.patch

set +e +o pipefail
