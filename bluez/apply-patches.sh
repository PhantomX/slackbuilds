
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Slackware

# Fixup the dbus config file for our usage:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bluez-dbus-config.patch

# Fedora
zcat ${SB_PATCHDIR}/${NAME}-socket-mobile-cf-connection-kit.patch.gz | patch -p1 -E --backup --verbose
# http://thread.gmane.org/gmane.linux.bluez.kernel/2396
patch -p1 -E --backup -z .cable-pairing --verbose -i ${SB_PATCHDIR}/0001-Add-sixaxis-cable-pairing-plugin.patch
# PS3 BD Remote patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-input-Add-helper-function-to-request-disconnect.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-fakehid-Disconnect-from-PS3-remote-after-10-mins.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-fakehid-Use-the-same-constant-as-declared.patch

set +e +o pipefail
