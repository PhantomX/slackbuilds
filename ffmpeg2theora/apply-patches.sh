
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Mageia
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.29-ffmpeg-2.0.patch

set +e +o pipefail
