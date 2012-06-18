
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
# File missing from the tarball
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-missing-org.bluez.service-file.patch
# Typo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-ALSA-plugin-having-full-soname.patch

set +e +o pipefail
