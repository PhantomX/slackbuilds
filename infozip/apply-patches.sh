  
SB_PATCHDIR=${CWD}/patches

( cd ${UNZIPSRCDIR} || exit 1
  # Not sent to upstream.
  zcat ${SB_PATCHDIR}/unzip-6.0-bzip2-configure.patch.gz | patch -p1 -E --backup --verbose || exit 1
  # Upstream plans to do this in zip (hopefully also in unzip).
  zcat ${SB_PATCHDIR}/unzip-6.0-exec-shield.patch.gz | patch -p1 -E --backup --verbose || exit 1
  # Upstream plans to do similar thing.
  zcat ${SB_PATCHDIR}/unzip-6.0-close.patch.gz | patch -p1 -E --backup --verbose || exit 1
  # Details in rhbz#532380.
  # Reported to upstream: http://www.info-zip.org/board/board.pl?m-1259575993/
  zcat ${SB_PATCHDIR}/unzip-6.0-attribs-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
) || exit 1

( cd ${ZIPSRCDIR} || exit 1
  # This patch will probably be merged to zip 3.1
  # http://www.info-zip.org/board/board.pl?m-1249408491/
  zcat ${SB_PATCHDIR}/zip-3.0-exec-shield.patch.gz | patch -p1 -E --backup --verbose || exit 1
  # Not upstreamed.
  zcat ${SB_PATCHDIR}/zip-3.0-currdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-no-crypt.patch.gz | patch -p0 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-pic.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
