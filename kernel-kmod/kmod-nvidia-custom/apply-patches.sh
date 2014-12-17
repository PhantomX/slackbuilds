
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/310.19-unified-arch.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/3.18_kernel.patch

set +e +o pipefail
