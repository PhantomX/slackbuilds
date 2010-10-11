
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-build-with-gcc-4.5.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-More-GCC-4.5-fixes-611588.patch

set +e +o pipefail
