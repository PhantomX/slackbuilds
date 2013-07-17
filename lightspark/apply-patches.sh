
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## RPMFusion
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.5-remove-llvm-version-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.2-llvm-libs-hack.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.2-llvm33.patch
## Mageia
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.2-ffmpeg-2.0.patch

set +e +o pipefail
