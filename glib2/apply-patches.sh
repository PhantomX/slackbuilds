  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-2.20.1-gio-unref.patch.gz | patch -p1 -E --backup --verbose || exit 1
