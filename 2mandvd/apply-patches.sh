
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-const-char-concatenation.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg.patch

set +e +o pipefail
