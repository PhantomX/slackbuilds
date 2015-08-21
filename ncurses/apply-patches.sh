
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

if [ "${PVER}" -ne 0 ] ; then
  bzcat ${SB_PATCHDIR}/updates/${PSRCARCHIVE} | patch -p1 --verbose
fi

# 5.9-20140524
rm -f Ada95/src/library.gpr

C=$(wc -l ${CWD}/${PSRCARCHIVES} | awk '{print $1}')
if [ "$C" -gt 0 ]; then
  mkdir -p updates
  cp ${SB_PATCHDIR}/updates/* updates/
  for file in $(<${CWD}/${PSRCARCHIVES}) ; do
    pver2=$(echo ${file} | cut -d- -f3 | cut -d. -f1)
    if [ "${pver2}" -gt "${PVER}" ] && [ -f ${SB_PATCHDIR}/updates/${file} ] ;then
      ( SB_PATCHDIR=updates
        zcat ${SB_PATCHDIR}/${file} | patch -p1 --verbose
      )
    fi
  done
fi

zcat ${SB_PATCHDIR}/ncurses.mkhashsize.diff.gz | patch -p1 --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ncurses-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ncurses-libs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ncurses-urxvt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ncurses-kbs.patch

set +e +o pipefail
