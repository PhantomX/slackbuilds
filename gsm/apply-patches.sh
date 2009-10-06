  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/gsm-makefile.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gsm-warnings.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gsm-64bit.patch.gz | patch -p1 -E --backup --verbose || exit 1
