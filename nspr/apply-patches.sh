
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-config-pc.patch.gz | patch -p0 -E --backup --verbose || exit 1
( cd mozilla || exit 1
  zcat ${SB_PATCHDIR}/prdtoa.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
