  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/javascript.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.4-kxsldbg-icons.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-r928380.patch.gz | patch -p4 -E --backup --verbose || exit 1
