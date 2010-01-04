  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.1.18-1.2.reduce-font.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-0.1.18-1.2.gzip-fonts.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.1.18-1.2.term.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.1.18-1.5.rh.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.1.9-2.6fbdev.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.1.18-noexecstack.patch.gz | patch -p1 -E --backup --verbose || exit 1
