  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/mesa-7.1-link-shared.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mesa-no-mach64.patch.gz | patch -p0 -E --backup --verbose || exit 1
