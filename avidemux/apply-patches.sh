
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.3-fontconfig.patch

## Patches from RPMFusion
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6-bundled_libs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}3-libass.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}3-bundled_libs.patch

set +e +o pipefail
