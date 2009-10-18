# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

if [ "${SNAPBUILD}" != "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-1.0.2-mimeopen.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-1.0.1-typo.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-1.0.1-htmlview.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-1.0.2-CVE-2008-0386.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-1.0.2-CVE-2009-0068-1.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
