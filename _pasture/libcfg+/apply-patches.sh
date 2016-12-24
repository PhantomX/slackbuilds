  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libcfg+-0.6.2-soname.patch.gz | patch -p0 -E --backup --verbose || exit 1
