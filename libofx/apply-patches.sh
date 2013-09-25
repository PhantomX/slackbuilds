
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-ftbfs-gcc4.7.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libofx-0.9.8-cout.patch

set +e +o pipefail
