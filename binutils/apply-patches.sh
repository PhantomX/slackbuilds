  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/binutils-2.20.51.0.5-libtool-lib64.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.20.51.0.3-envvar-revert.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.20.51.0.2-set-long-long.patch.gz | patch -p0 -E --backup --verbose || exit 1
