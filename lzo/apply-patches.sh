  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/lzo-2.02-configure.patch.gz | patch -p1 -E --backup --verbose || exit 1
