  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libksba-1.0.6-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
