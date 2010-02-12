
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.7.2-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1.0-conflict.patch.gz | patch -p1 -E --backup --verbose || exit 1
