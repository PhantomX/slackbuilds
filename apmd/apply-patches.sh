  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.2-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2-umask.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2-error.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_X}" != "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-3.2-x.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
