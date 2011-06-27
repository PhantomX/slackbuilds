
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nucleo-0.7.6-v4l1.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nucleo-0.7.6-ffmpeg.patch
zcat ${SB_PATCHDIR}/nucleo-0.7.6-png14.patch.gz | patch -p0 -E --backup --verbose || exit 1

set +e +o pipefail
