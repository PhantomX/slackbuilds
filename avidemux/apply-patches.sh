
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.6-coreImage-parallel-build.patch
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-build-plugins-fix.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.3-fontconfig.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.6-ffmpeg-symbol-visibility.patch

## Patches from RPMFusion
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4-qt4.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.3-mpeg2enc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.3-pluginlibs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.6-ffmpeg_aac.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.5-gcc46_tmp_fix.patch
# Use system libraries
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.4-libass.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.4-liba52.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.4-libmad.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.4-libtwolame.patch

set +e +o pipefail
