
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

( cd ${YPBSRCDIR}
  zcat ${SB_PATCHDIR}/ypbind-1.11-gettextdomain.patch.gz | patch -p1 -E --backup --verbose
)

( cd ${YPSSRCDIR}
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.21-path.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.13-ypxfr-zeroresp.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.13-nonedomain.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.19-slp-warning.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.24-manfix.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.24-aliases.patch
)

set +e +o pipefail
