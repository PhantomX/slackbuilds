  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/nouveau-store-vbios.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/dcbconf_7_4_ignore.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nouveau-multiple-xserver.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nouveau-bicubic-2x.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nouveau-bgnr.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nouveau-tile7000.patch.gz | patch -p1 -E --backup --verbose || exit 1
