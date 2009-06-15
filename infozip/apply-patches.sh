  
SB_PATCHDIR=${CWD}/patches

( cd ${UNZIPSRCDIR} || exit 1
) || exit 1

( cd ${ZIPSRCDIR} || exit 1
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-exec-stack.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-no-crypt.patch.gz | patch -p0 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-pic.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
