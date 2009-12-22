  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.11.65-python26.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.21.2-gcc44-relocate.patch.gz | patch -p0 -E --backup --verbose || exit 1
