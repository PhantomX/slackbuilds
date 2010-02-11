  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.5.10-r957058.patch.gz | patch -p4 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-r960293.patch.gz | patch -p4 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-gcc44.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.7-subversion.patch.gz | patch -p1 -E --backup --verbose || exit 1
