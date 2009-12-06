  
SB_PATCHDIR=${CWD}/patches

( cd sv7 || exit
  zcat ${SB_PATCHDIR}/${NAME}-1.15v-Makefile.patch.gz | patch -p0 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-1.15v-gcc4.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-1.15v-Makefile-esd.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
