  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/composite-cube-logo.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.8.2-wall.patch.gz | patch -p1 -E --backup --verbose || exit 1
