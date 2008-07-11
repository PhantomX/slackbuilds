  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIRNAME}-no-xv.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-lib64.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-giftrans.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.1.6-sane-types.patch.gz | patch -p1 -E --backup --verbose  || exit 1
