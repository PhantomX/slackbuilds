
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd ${UNZIPSRCDIR}
  # Not sent to upstream.
   patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/unzip-6.0-bzip2-configure.patch
  # Upstream plans to do this in zip (hopefully also in unzip).
  zcat ${SB_PATCHDIR}/unzip-6.0-exec-shield.patch.gz | patch -p1 -E --backup --verbose
  # Upstream plans to do similar thing.
  zcat ${SB_PATCHDIR}/unzip-6.0-close.patch.gz | patch -p1 -E --backup --verbose
  # Details in rhbz#532380.
  # Reported to upstream: http://www.info-zip.org/board/board.pl?m-1259575993/
  zcat ${SB_PATCHDIR}/unzip-6.0-attribs-overflow.patch.gz | patch -p1 -E --backup --verbose
)

( cd ${ZIPSRCDIR}
  # This patch will probably be merged to zip 3.1
  # http://www.info-zip.org/board/board.pl?m-1249408491/
  zcat ${SB_PATCHDIR}/zip-3.0-exec-shield.patch.gz | patch -p1 -E --backup --verbose
  # Not upstreamed.
  zcat ${SB_PATCHDIR}/zip-3.0-currdir.patch.gz | patch -p1 -E --backup --verbose
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-build.patch.gz | patch -p1 -E --backup --verbose
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-no-crypt.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/${ZIPNAME}-3.0-pic.patch.gz | patch -p0 -E --backup --verbose
)

set +e +o pipefail
