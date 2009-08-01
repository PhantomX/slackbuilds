  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/zlib-1.2.3-autotools.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/minizip-1.2.3-autotools.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/zlib-1.2.3-minizip.patch.gz | patch -p1 -E --backup --verbose || exit 1
