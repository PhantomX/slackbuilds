
SB_PATCHDIR=${CWD}/patches

if [ "${PVER}" -ne 0 ] ; then
  bzcat ${CWD}/${PSRCARCHIVE} | patch -p1 --verbose || exit 1
fi

C=$(wc -l ${CWD}/${PSRCARCHIVES} | awk '{print $1}')
if [ "$C" -gt 0 ]; then
  for file in $(<${CWD}/${PSRCARCHIVES}) ; do
    zcat ${SB_PATCHDIR}/updates/${file} | patch -p1 --verbose || exit 1
  done
fi

zcat ${SB_PATCHDIR}/${NAME}.mkhashsize.diff.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-5.7-20090124-config.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.6-20070612-libs.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.6-20080112-xterm.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.6-20080112-urxvt.patch.gz | patch -p1 --verbose || exit 1

