  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.99.2-archive-integration.patch.gz | patch -p0 -E --backup --
zcat ${SB_PATCHDIR}/${NAME}-obexftp-updated-apis-2.patch.gz | patch -p0 -E --backup --verbose || exit 1
