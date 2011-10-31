
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Makefile-cleanup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Add-defines-for-PCI-IDs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Add-qemu-stdvga-pci-bios.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-update-pci_get_lfb_addr-for-vmware-vga.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Add-qemu-vmware-vga-pci-bios.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-Add-qemu-qxl-vga-pci-bios.patch

set +e +o pipefail
