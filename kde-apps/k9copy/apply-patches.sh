
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .ffmpeg --verbose -i ${SB_PATCHDIR}/k9copy-3.0.3-ffmpeg.patch

set +e +o pipefail
