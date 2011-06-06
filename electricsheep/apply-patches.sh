
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}.mplayer.diff.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-xdg-utils.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup -z .ffmpeg --verbose -i ${SB_PATCHDIR}/${NAME}-ffmpeg.patch

set +e +o pipefail
