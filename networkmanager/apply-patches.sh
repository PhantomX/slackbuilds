
set -x -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-error.patch

# From Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-dbus_access_network_manager.patch

# From Gentoo
# Bug #402085, https://bugzilla.gnome.org/show_bug.cgi?id=387832
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.7.995-pre-sleep.patch

# From Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/disable_set_hostname.patch

set +e +o pipefail
