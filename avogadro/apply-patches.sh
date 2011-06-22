
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix qmake mkspecs installation directory (broken in 1.0.3)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-mkspecs-dir.patch
# Remove -Wl,-s from the compiler flags, fixes -debuginfo (#700080)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-no-strip.patch

set +e +o pipefail
