  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/mysql-libdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
