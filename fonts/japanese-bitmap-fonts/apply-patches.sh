  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/k14.patch.gz | patch -p0 -E --backup --verbose || exit 1
cp k14.bdf k14-1990.bdf
zcat ${SB_PATCHDIR}/k14-1990.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/fonts-ja-8.0-gcc-warnings.patch.gz | patch -p1 -E --backup --verbose || exit 1
( cd ${SRCDIR10}
  zcat ${SB_PATCHDIR}/mplus_bitmap_fonts-install.patch.gz | patch -p1 -E --backup --verbose || exit 1
) || exit 1
zcat ${SB_PATCHDIR}/fonttools-replace.patch.gz | patch -p1 -E --backup --verbose || exit 1
