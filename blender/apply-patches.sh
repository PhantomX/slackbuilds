
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .droid --verbose -i ${SB_PATCHDIR}/${NAME}-2.76-droid.patch
patch -p1 -E --backup -z .ffmpeg --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg.patch

set +e +o pipefail
