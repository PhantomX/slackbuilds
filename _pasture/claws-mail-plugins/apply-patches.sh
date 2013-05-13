
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd geolocation_plugin-*
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-geolocation-champlain-0.9.patch
)

set +e +o pipefail
