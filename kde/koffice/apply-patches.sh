  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/koffice-libpng14.patch.gz | patch -p0 -E --backup --verbose || exit 1
