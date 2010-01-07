  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libtiff-acversion.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-mantypo.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-CVE-2009-2347.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-jpeg-scanline.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtiff-scanlinesize.patch.gz | patch -p1 -E --backup --verbose || exit 1
