  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.99.2-archive-integration.patch.gz | patch -p0 -E --backup --
zcat ${SB_PATCHDIR}/${NAME}-obexftp-updated-apis.patch.gz | patch -p0 -E --backup --verbose || exit 1
