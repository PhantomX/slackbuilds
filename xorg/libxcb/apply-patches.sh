  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libxcb-1.1-abstract-socket.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libxcb-1.1-no-pthread-stubs.patch.gz | patch -p1 -E --backup --verbose || exit 1
