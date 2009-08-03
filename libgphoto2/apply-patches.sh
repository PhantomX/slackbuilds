  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libgphoto2-pkgcfg.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libgphoto2-storage.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libgphoto2-ixany.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libgphoto2-maxentries.patch.gz | patch -p1 -E --backup --verbose || 
zcat ${SB_PATCHDIR}/libgphoto2-libusb-fix-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
