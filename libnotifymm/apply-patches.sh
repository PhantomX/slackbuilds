
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libnotifymm-0.6.1-pkgconfig.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/libnotifymm-0.6.1-bodgenewapi.patch

set +e +o pipefail
