
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd ${RSRCDIR}
  patch -p1 -E --backup -z .configdir --verbose -i ${SB_PATCHDIR}/oss-4.2-configdir.patch
) || exit 1

set +e +o pipefail
