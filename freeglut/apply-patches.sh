
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix linking of the examples
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/freeglut-2.8.0-fixld.patch
# Fix for conflicting types found in GLext
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/freeglut-glextconflict.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/freeglut-2.8.0-fixXInput.patch

set +e +o pipefail
