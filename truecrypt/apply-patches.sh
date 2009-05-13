  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-6.0a-linux-umount-fixed.patch.gz | patch -p1 -E --backup --verbose || exit 1
