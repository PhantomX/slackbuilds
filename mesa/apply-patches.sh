
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/i965_Remove_early_release_of_DRI2_miptree.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-9.2-hardware-float.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-10.2-evergreen-big-endian.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
