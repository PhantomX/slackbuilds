
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patches from master
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-bug17754.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-address-reuse.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-assert-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-add-unit-tests.patch

set +e +o pipefail
