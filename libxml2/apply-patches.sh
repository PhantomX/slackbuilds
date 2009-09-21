  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libxml2-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libxml2-2.7.4-input-parser.patch.gz | patch -p1 -E --backup --verbose || exit 1
