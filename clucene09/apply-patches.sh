
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/clucene-core-0.9.21b-gcc48.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/clucene-core-0.9.21b-enable-refcount.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/clucene-core-0.9.21b-fix-soversion.patch
touch src/Makefile.in
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/clucene-core-0.9.21b-verbose-tests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/clucene-core-0.9.21b-fix-unescaping.patch

set +e +o pipefail
