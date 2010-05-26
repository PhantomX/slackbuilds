
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbusmenu-qt-0.3.2-pkgconfig.patch

set +e +o pipefail
