
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libresample-0.1.3-shlib-cmake.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libresample-0.1.3-shlib-cmake-pkgconfig.patch

set +e +o pipefail
