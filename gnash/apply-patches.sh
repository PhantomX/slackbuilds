  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/gnash-0.8.3-boost-dynamic-link.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gnash-0.8.3-fix-kde4-port.patch.gz | patch -p1 -E --backup --verbose || exit 1
