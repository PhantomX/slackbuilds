
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-labels.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-valgrind.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-build-fixes.patch

set +e +o pipefail
