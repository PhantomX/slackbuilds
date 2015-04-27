
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## RPMFusion
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.5-remove-llvm-version-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.2-llvm-libs-hack.patch

### Debian/Ubuntu
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-for-llvm33.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/detect-llvm34.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-for-llvm34.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-for-llvm35.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lightspark-llvm36.patch

### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.2-ffmpeg20.patch

set +e +o pipefail
