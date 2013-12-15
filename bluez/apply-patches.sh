
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

### Slackware

# Fixup the dbus config file for our usage:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bluez-dbus-config.patch

### Fedora
## Ubuntu patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-work-around-Logitech-diNovo-Edge-keyboard-firmware-i.patch
# Non-upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Allow-using-obexd-without-systemd-in-the-user-sessio.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-obex-Use-GLib-helper-function-to-manipulate-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-autopair-Don-t-handle-the-iCade.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-agent-Assert-possible-infinite-loop.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-sixaxis-Fix-device-detection.patch

set +e +o pipefail
