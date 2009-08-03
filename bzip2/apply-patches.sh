  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/bzip2-1.0.4.saneso.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/bzip2-1.0.4-cflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/bzip2-1.0.4-bzip2recover.patch.gz | patch -p1 -E --backup --verbose || exit 1
