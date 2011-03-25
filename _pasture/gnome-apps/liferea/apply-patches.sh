
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lX11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libnotify-0.7-api.patch

set +e +o pipefail
