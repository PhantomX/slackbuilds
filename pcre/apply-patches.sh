  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/pcre-7.3-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
