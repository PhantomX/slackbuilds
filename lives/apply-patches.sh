
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .ffmpeg --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.7-ffmpeg.patch

set +e +o pipefail
