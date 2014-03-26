
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
rm -rf js/src/editline -rf
rm -rf js/src/ctypes/libffi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/js17-build-fixes.patch

set +e +o pipefail
