  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/opensp-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/opensp-nodeids.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/opensp-sigsegv.patch.gz | patch -p1 -E --backup --verbose || exit 1
