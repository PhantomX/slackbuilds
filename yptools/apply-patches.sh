  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-2.7-md5.patch.gz | patch -p1 -E --backup --verbose || exit 1

( cd ${YPBSRCDIR} || exit 1
  zcat ${SB_PATCHDIR}/ypbind-1.11-broadcast.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypbind-1.11-gettextdomain.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypbind-mt-1.19-port-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypbind-mt-1.19-log-binds.patch.gz | patch -p1 -E --backup --verbose || exit 1
) || exit 1

( cd ${YPSSRCDIR} || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.11-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.5-nfsnobody2.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.11-nomap.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.11-iface-binding3.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.13-yplib-memleak.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.13-ypxfr-zeroresp.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.19-inval-ports.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.13-nonedomain.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.19-quieter.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.19-debuginfo.patch.gz | patch -p1 -E --backup --verbose || exit 1
  zcat ${SB_PATCHDIR}/ypserv-2.19-slp-warning.patch.gz | patch -p1 -E --backup --verbose || exit 1
) || exit 1
