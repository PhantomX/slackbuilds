  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libusb-0.1.12-libusbconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libusb-0.1.12-memset.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libusb-0.1.12-openat.patch.gz | patch -p1 -E --backup --verbose || exit 1
