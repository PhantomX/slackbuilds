  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libiec61883-1.2.0-installtests.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libiec61883-channel-allocation-without-local-node-rw.patch.gz | patch -p1 -E --backup --verbose || exit 1
