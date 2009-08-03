  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libgcrypt-1.4.4-multilib.patch.gz | patch -p0 -E --backup --verbose || exit 1
