  
SB_PATCHDIR=${CWD}/tpatches

zcat ${SB_PATCHDIR}/${NAME}-102434.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-cookie.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-viewer-reparent.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}10-rh495457.patch.gz | patch -p0 -E --backup --verbose || exit 1
