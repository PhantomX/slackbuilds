  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libexif.pc.diff.gz | patch -p0 -E --backup --verbose || exit 1
