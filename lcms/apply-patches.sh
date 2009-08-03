  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/lcms-CVE-2009-0793.patch.gz | patch -p1 -E --backup --verbose || exit 1
