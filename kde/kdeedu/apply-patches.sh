  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.3.90-cantor_part_desktop_fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
