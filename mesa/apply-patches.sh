
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-llvm-SONAME-without-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-hardware-gloat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-evergreen-big-endian.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-bigendian-assert.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
