  
SB_PATCHDIR=${CWD}/patches

if [ "${SNAPBUILD}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-MCS-defines.patch.gz | patch -p0 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-jstest-segv.patch.gz | patch -p1 -E --backup --verbose || exit 1
else
  zcat ${SB_PATCHDIR}/${NAME}-1.2.15-redhat.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-1.2.15-newkernel.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
