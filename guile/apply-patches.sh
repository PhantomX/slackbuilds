  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/guile-1.8.7-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/guile-1.8.7-testsuite.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/guile-1.8.6-deplibs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/guile-1.8.7-linemarkers.patch.gz | patch -p1 -E --backup --verbose || exit 1
