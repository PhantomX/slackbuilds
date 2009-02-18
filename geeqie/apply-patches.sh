  
SB_PATCHDIR=${CWD}/patches

# bz 222639
zcat ${SB_PATCHDIR}/${NAME}-1.0alpha1-print-pagesize.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.0alpha2-gcc-warn.patch.gz | patch -p1 -E --backup --verbose || exit 1
