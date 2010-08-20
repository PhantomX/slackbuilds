
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

if [ "${SB_PATCH}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${CWD}/${PSRCARCHIVE}
fi

set +e +o pipefail
