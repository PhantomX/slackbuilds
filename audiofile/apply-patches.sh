  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/audiofile-underquoted.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/audiofile-const.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/audiofile-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
