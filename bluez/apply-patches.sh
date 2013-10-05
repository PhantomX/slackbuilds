
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

### Slackware

# Fixup the dbus config file for our usage:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bluez-dbus-config.patch

### Fedora
## https://bugzilla.redhat.com/show_bug.cgi?id=874015#c0
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/playstation-peripheral-pugin-v5.x.patch
## Ubuntu patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-work-around-Logitech-diNovo-Edge-keyboard-firmware-i.patch
# https://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=12494337e4ce67ce927bd2d8c86e9c176ec3e36f
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-core-Fix-passing-timeout-when-disabling-discoverable.patch

set +e +o pipefail
