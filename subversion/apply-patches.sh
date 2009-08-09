  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.6.0-deplibs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.6.1-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-1.6.0-pie.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_JAVA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-1.1.3-java.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
zcat ${SB_PATCHDIR}/${NAME}-1.6.2-kwallet.patch.gz | patch -p1 -E --backup --verbose || exit 1
