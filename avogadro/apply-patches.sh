
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix qmake mkspecs installation directory (broken in 1.0.3)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-mkspecs-dir.patch
# Remove -Wl,-s from the compiler flags, fixes -debuginfo (#700080)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.1-no-strip.patch
# avogadro.pc missing eigen dependency
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.1-pkgconfig_eigen.patch
# fix build with cmake-3.2+
# https://sourceforge.net/p/avogadro/bugs/746/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-cmake-3.2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.1-eigen3.patch

set +e +o pipefail
