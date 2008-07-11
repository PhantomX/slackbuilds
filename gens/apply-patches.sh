  
SB_PATCHDIR=${CWD}/patches

if [ "${SNAPBUILD}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-miscfixes-gxx.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-keycombofix.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-no-startup-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
else
  zcat ${SB_PATCHDIR}/${NAME}-2.12b-gcc4.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-2.12-analog-joy.patch.gz | patch -p0 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-2.12b-romsdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
