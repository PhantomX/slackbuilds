  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libxslt-1.1.24-exslt_crypt.patch.gz | patch -p0 -E --backup --verbose || exit 1
