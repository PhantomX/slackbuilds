
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/x11.startwithblackscreen.diff

# Patches from Fedora

# This really could be done prettier.
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.4.99-ssh-isnt-local.patch

# don't build the (broken) acpi code
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.0-less-acpi-brokenness.patch

# ajax needs to upstream this
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.0-displayfd.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.99-right-of.patch
#zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose

# backport pci slot claiming fix for kms drivers
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-fix-pci-slot-claims.patch
# backport modesetting fallback driver
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.12-modesetting-fallback.patch
# needed when building without xorg (aka s390x)
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.12.2-xorg-touch-test.patch

# misc
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-Fix-segfault-when-killing-X-with-ctrl-alt-backspace.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/sync-fix.patch

patch -p0 --verbose -i ${SB_PATCHDIR}/xserver-1.11.0-force-hal-disable.patch
if [ "${SB_ZW}" = "YES" ] ;then
  patch -p1 --verbose -z .zap-warning -i ${SB_PATCHDIR}/xserver-zap-warning.patch
fi

set +e +o pipefail
