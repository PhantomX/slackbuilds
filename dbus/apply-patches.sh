
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From stock
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-1.4.x-allow_root_globally.diff

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/dbus-1.8.0-systemd209.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
