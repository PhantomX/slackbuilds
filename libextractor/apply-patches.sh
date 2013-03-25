
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix build with giflib >= 4.2.0
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libextractor-giflib420.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libextractor-ffmpeg.patch

set +e +o pipefail
