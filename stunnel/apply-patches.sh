  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.27-sample.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.27-aliasing.patch.gz | patch -p1 -E --backup --verbose || exit 1
