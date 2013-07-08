
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Put video parameters after audio.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-command-order.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg.patch

# git patches

set +e +o pipefail
