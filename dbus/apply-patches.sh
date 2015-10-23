
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From stock
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-1.4.x-allow_root_globally.diff


### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-user-dbus.socket-Set-DBUS_SESSION_BUS_ADDRESS.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
