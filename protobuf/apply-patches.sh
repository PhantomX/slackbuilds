
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.1-fedora-gtest.patch
rm -rf gtest
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.0-java-fixes.patch
rm -rf java/src/test

set +e +o pipefail
