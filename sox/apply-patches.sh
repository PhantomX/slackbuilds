
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sox-14.4.0-ffmpeg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sox-14.4.0-avcodec54.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sox-14.4.0-libav-9.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sox-mcompand_clipping.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/sox-ffmpeg55.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
