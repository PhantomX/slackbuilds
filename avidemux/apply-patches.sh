
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.6-coreImage-parallel-build.patch
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-build-plugins-fix.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.3-fontconfig.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.6-ffmpeg-symbol-visibility.patch

set +e +o pipefail
