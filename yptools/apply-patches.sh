
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Slackware
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/yp-tools-2.14-glibc217-crypt.diff

( cd ${YPBSRCDIR}
  zcat ${SB_PATCHDIR}/ypbind-1.11-gettextdomain.patch.gz | patch -p1 -E --backup --verbose
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypbind-mt-1.37.1-systemd209.patch
)

( cd ${YPSSRCDIR}
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.21-path.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.13-ypxfr-zeroresp.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.13-nonedomain.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.19-slp-warning.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.24-manfix.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.24-aliases.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ypserv-2.31-systemd209.patch
)



# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
