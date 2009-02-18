  
SB_PATCHDIR=${CWD}/patches

# zcat ${SB_PATCHDIR}/${NAME}-0.99.3-datadir-locale-dir-fix.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-dont-forward-keycode-0.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.1.99.2-compose-updates.patch.gz | patch -p1 -E --backup --verbose || exit 1
