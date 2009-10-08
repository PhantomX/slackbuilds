  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
