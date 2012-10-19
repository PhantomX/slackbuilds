
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nm-polkit-permissive.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-error.patch

# From Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-dbus_access_network_manager.patch

# From Gentoo
# Bug #402085, https://bugzilla.gnome.org/show_bug.cgi?id=387832
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.2.0-pre-sleep.patch
# Bug #335147, https://bugzilla.gnome.org/show_bug.cgi?id=679428
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.4.0-dhclient-ipv6.patch
# Bug #428274, don't save temporary ipv6 routes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.6.0-cached-ipv6-routes-1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.6.0-cached-ipv6-routes-2.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=683932
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/networkmanager-0.9.6.0-daemon-signals.patch
  
set +e +o pipefail
