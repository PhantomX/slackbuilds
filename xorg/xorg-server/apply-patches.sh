
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

patch -p1 --verbose -i ${SB_PATCHDIR}/0001-linux-Refactor-xf86-En-Dis-ableIO.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0002-linux-Make-failure-to-iopl-non-fatal.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0003-xfree86-Change-the-semantics-of-driverFunc-GET_REQUI.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-Always-install-vbe-and-int10-sdk-headers.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/0001-xf86-return-NULL-for-compat-output-if-no-outputs.patch

# kernel doesn't use _INPUT_H anymore
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-xf86-Fix-build-against-recent-Linux-kernel.patch

# Bug 878956 - After installation is complete, Alt+F4 is broken
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-linux-Prefer-ioctl-KDSKBMUTE-1-over-ioctl-KDSKBMODE-.patch

# mustard: make the default queue length bigger to calm abrt down
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-mieq-Bump-default-queue-size-to-512.patch

# some hotplug fixes/workaround
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-xfree86-hotplug-cleanup-properly-if-the-screen-fails.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-xf86crtc-don-t-use-display-for-vx-vy-for-gpu-screens.patch

# on way upstream: fixes for reverse optimus
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-dix-allow-pixmap-dirty-helper-to-be-used-for-non-sha.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-xserver-call-CSR-for-gpus.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-xf86-actually-set-the-compat-output-in-the-failure-c.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-randr-cleanup-provider-properly.patch

# misc
patch -p1 --verbose -i ${SB_PATCHDIR}/0001-Fix-segfault-when-killing-X-with-ctrl-alt-backspace.patch

patch -p0 --verbose -i ${SB_PATCHDIR}/xserver-1.11.0-force-hal-disable.patch
if [ "${SB_ZW}" = "YES" ] ;then
  patch -p1 --verbose -z .zap-warning -i ${SB_PATCHDIR}/xserver-zap-warning.patch
fi

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
