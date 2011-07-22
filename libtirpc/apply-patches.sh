
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtirpc-0.2.1-fortify.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtirpc-0.2.3-rc1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtirpc-0.2.2-wrap-segfault.patch

set +e +o pipefail
