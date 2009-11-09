  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libfreebob-1.0.11-includes.patch.gz | patch -p1 -E --backup --verbose || exit 1
