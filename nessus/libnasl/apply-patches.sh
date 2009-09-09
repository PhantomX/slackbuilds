  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-config.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.2.4.pki.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-nasl-config-multi.patch.gz | patch -p0 -E --backup --verbose || exit 1
# fix #479655 bad signature check
zcat ${SB_PATCHDIR}/${NAME}-openssl.patch.gz | patch -p0 -E --backup --verbose || exit 1
