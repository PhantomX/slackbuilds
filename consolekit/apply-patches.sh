  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/nodaemon.patch.gz | patch -p1 -E --backup --verbose || exit 1
