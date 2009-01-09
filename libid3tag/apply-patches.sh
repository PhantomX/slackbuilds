  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.15.1b-64bit-long.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.15.1b-a_capella.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.15.1b-compat.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.15.1b-file-write.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.15.1b-fix_overflow.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.15.1b-tag.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.15.1b-unknown-encoding.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.15.1b-utf16.patch.patch.gz | patch -p1 -E --backup --verbose || exit 1
