
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vesa-2.3.0-24bpp-sucks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vesa-2.3.0-no-virt-shadowfb.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-check-function-in-VESASaveRestore.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Remove-mibstore.h.patch

set +e +o pipefail
