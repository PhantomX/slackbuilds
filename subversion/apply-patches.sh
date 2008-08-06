  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.20.1-deplibs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5.1-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5.0-pie.patch.gz | patch -p1 -E --backup --verbose || exit 1
[ "${SB_JAVA}" = "YES" ] && \
  zcat ${SB_PATCHDIR}/${NAME}-1.1.3-java.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-1.5.0-perl510.patch.gz | patch -p1 -E --backup --verbose || exit 1
