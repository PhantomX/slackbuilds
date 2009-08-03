  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/tiffsplit-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-3.8.2-ormandy.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-3.8.2-CVE-2006-2193.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-3.8.2-mantypo.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-3.8.2-lzw-bugs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-3.8.2-CVE-2009-2347.patch.gz | patch -p1 -E --backup --verbose || exit 1
