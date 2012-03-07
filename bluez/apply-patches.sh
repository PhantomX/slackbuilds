
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Slackware

# Fixup the dbus config file for our usage:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bluez-dbus-config.patch
# Use a wrapper to check rc.bluetooth mode before starting bluetoothd
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bluez-run_udev_helper.patch

# Fedora
zcat ${SB_PATCHDIR}/${NAME}-socket-mobile-cf-connection-kit.patch.gz | patch -p1 -E --backup --verbose
# http://thread.gmane.org/gmane.linux.bluez.kernel/2396
patch -p1 -E --backup -z .cable-pairing --verbose -i ${SB_PATCHDIR}/0001-Add-sixaxis-cable-pairing-plugin.patch
# http://thread.gmane.org/gmane.linux.bluez.kernel/8645
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-systemd-install-systemd-unit-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sbc_mmx.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cplusplus_void_cast.patch

set +e +o pipefail
