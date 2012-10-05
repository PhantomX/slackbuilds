
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
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.99-right-of.patch
#zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose

# backport pci slot claiming fix for kms drivers
# needed when building without xorg (aka s390x)
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.12.2-xorg-touch-test.patch

# send keycode/event type for slow keys enable (#816764)
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.12-xkb-fill-in-keycode-and-event-type-for-slow-keys-ena.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/0001-linux-Refactor-xf86-En-Dis-ableIO.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0002-linux-Make-failure-to-iopl-non-fatal.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0003-xfree86-Change-the-semantics-of-driverFunc-GET_REQUI.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-Always-install-vbe-and-int10-sdk-headers.patch

# backport dri2 drawable fix
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-dri2-invalidate-drawable-after-sharing-pixmap.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/0001-xf86-return-NULL-for-compat-output-if-no-outputs.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/0001-scan-pci-after-probing-devices.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/0001-config-udev-ignore-change-on-drm-devices.patch

# Bug 852841 - Mouse jumps to edges / corners when using an absolute input
# device (ie virtual machine usb tablet)
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-dix-set-the-device-transformation-matrix.patch

# misc
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-Fix-segfault-when-killing-X-with-ctrl-alt-backspace.patch

patch -p0 --verbose -i ${SB_PATCHDIR}/xserver-1.11.0-force-hal-disable.patch
if [ "${SB_ZW}" = "YES" ] ;then
  patch -p1 --verbose -z .zap-warning -i ${SB_PATCHDIR}/xserver-zap-warning.patch
fi

set +e +o pipefail
