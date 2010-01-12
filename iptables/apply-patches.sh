  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.4.5-cloexec.patch.gz | patch -p1 -E --backup --verbose || exit 1
