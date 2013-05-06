
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-ffmpeg-0.11.patch
patch -p1 -E --backup -z .ffmpeg --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-ffmpegfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-includepaths.patch

set +e +o pipefail
