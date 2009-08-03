  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/esound-0.2.38-drain.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/esound-0.2.38-fix-open-macro.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/remove-confusing-spew.patch.gz | patch -p1 -E --backup --verbose || exit 1
