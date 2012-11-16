
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Put video parameters after audio.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-command-order.patch
# git patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg.patch

set +e +o pipefail
