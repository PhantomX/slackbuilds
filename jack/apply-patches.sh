  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/jack-audio-connection-kit-0.116.1-cleanup-mb-thread.patch.gz | patch -p1 -E --backup --verbose || exit 1
