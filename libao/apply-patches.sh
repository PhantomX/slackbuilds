  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libao-0.8.8-bigendianfix.patch.gz | patch -p1 -E --backup --verbose || exit 1
