  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libavc1394-0.5.1-librom.patch.gz | patch -p1 -E --backup --verbose || exit 1
