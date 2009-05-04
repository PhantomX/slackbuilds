  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${BNAME}-1.0.20-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${BNAME}-1.0.19-glibc-2.7.patch.gz | patch -p1 -E --backup --verbose || exit 1

( cd ${FSRCDIR} || exit 1
  zcat ${SB_PATCHDIR}/${FNAME}-1.0.14-badcode.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${FNAME}-1.0.14-remove-obsolete-cap.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
