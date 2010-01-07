  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libXt-1.0.2-libsm-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
