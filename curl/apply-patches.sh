  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/curl-7.15.3-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/curl-7.20.0-privlibs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/curl-7.19.4-debug.patch.gz | patch -p1 -E --backup --verbose || exit 1
