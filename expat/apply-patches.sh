  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/expat-2.0.1-confcxx.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/expat-1.95.8-CVE-2009-3560.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/expat-1.95.8-CVE-2009-3720.patch.gz | patch -p1 -E --backup --verbose || exit 1
