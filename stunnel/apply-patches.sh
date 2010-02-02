  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.30-sample.patch.gz | patch -p1 -E --backup --verbose || exit 1
