  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.6.8-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
