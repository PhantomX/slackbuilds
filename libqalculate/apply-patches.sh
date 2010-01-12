  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-gcc43.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.6-pkgconfig_private.patch.gz | patch -p1 -E --backup --verbose || exit 1
