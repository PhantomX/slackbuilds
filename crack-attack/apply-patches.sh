  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/crack-attack-1.1.14-glutInit.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/crack-attack-1.1.14-sanitize.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/crack-attack-1.1.14-audio.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/crack-attack-1.1.14-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
