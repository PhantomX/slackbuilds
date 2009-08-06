  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.5-cxx.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5-amd64.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5-dependency.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
