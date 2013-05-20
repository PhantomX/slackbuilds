
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.0-fedora-gtest.patch
rm -rf gtest
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.0-java-fixes.patch
rm -rf java/src/test
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-generic-GCC-support-for-atomic-operations.patch

set +e +o pipefail
