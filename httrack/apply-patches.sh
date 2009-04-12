  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.43.2-utf-8.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.43.2-openssl.patch.gz | patch -p1 -E --backup --verbose || exit 1
