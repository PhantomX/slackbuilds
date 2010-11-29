
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd ${RSRCDIR}
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/oss-kernel-2.6.36.patch
) || exit 1

set +e +o pipefail
