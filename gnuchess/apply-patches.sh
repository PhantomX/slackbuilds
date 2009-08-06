  
SB_PATCHDIR=${CWD}/patches

# make gnuchess compile with gcc4
zcat ${SB_PATCHDIR}/${NAME}.gcc4_fix.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# Fix for glibc >= 2.9.90
zcat ${SB_PATCHDIR}/${NAME}-5.07-glibc.patch.gz | patch -p0 --verbose --backup --suffix=.orig || exit 1

( cd ${EBSRCDIR} || exit 1
  zcat ${SB_PATCHDIR}/${EBNAME}-1.1.1-gcc44.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
) || exit 1

( cd ${XBSRCDIR} || exit 1
  # --infodir is fubar.
  zcat ${SB_PATCHDIR}/${XBNAME}.infodir.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
  # Taken from Debian to fix CVE-2004-2552
  # FOR WHICH THERE IS NO ATTACK VECTOR!!!
  zcat ${SB_PATCHDIR}/${XBNAME}.buffer_overflow_fix.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
) || exit 1
