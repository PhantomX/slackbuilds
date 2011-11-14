
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/charls_add_cmake_install_target.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/charls_add_sharedlib_soname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/charls_fix_tests.patch

set +e +o pipefail
