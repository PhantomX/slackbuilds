  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/nouveau-bicubic-2x.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nouveau-bgnr.patch.gz | patch -p1 -E --backup --verbose || exit 1
