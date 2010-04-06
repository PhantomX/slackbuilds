
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc-44.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-c++-build-fix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-c++-revert-error.patch

set +e +o pipefail
