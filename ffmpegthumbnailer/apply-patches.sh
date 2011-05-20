
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.6-asneeded.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.6-flags.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.6-ffmpeg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.0.6-gcc46.patch

set +e +o pipefail
