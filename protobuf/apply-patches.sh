  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-pkgconfig-autotools.patch.gz | patch -p1 -E --backup --verbose || exit 1
