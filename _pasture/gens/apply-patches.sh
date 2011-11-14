  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-keycombofix.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.15.5-romsdir.patch.gz | patch -p0 -E --backup --verbose || exit 1
