
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.0.4.external_dv.patch.gz | patch -p1 -E --backup --verbose
rm -f filter/preview/dv_types.h
### Gentoo
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-ffmpeg.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-ffmpeg-0.10.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-ffmpeg-0.11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-preset-free.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-libav-9.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-libav-10.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-preset-force.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-ffmpeg2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-ffmpeg24.patch

patch -p1 -E --backup -z .ffmpeg28 --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.7-ffmpeg-2.8.patch

set +e +o pipefail
