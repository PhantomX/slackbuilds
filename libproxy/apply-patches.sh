
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-r870.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-r873.patch

set +e +o pipefail
