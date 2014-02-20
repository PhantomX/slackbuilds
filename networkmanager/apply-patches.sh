
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rh978435-dns-none.patch

### Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-dbus_access_network_manager.patch

### Gentoo
# Bug #402085, https://bugzilla.gnome.org/show_bug.cgi?id=387832
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.7.995-pre-sleep.patch

### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/disable_set_hostname.patch

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.8.8-systemd209.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
