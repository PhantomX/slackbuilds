
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/x11.startwithblackscreen.diff.gz | patch -p1 --verbose
#zcat ${SB_PATCHDIR}/xorgconfig.diff.gz | patch -p1 --verbose
#zcat ${SB_PATCHDIR}/xorg-server.dpi.diff.gz | patch -p1 --verbose

# Patches from Fedora
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.5.0-bg-none-root.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.8.0.901-pic-libxf86config.patch
zcat ${SB_PATCHDIR}/xserver-1.7.4-z-now.patch.gz | patch -p1 --verbose
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.5.0-projector-fb-size.patch

# This really could be done prettier.
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.4.99-ssh-isnt-local.patch

# force mode debugging on for randr 1.2 drivers
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.5.1-mode-debug.patch

# don't build the (broken) acpi code
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.0-less-acpi-brokenness.patch

# Make autoconfiguration chose nouveau driver for NVIDIA GPUs
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.1-nouveau.patch

# ajax needs to upstream this
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.0-displayfd.patch
zcat ${SB_PATCHDIR}/xserver-1.6.99-randr-error-debugging.patch.gz | patch -p1 --verbose
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.99-right-of.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.99-default-modes.patch
#zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose

patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.7.1-multilib.patch

# https://bugs.freedesktop.org/show_bug.cgi?id=28672
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.8.0-no-xorg.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.9.0-tcflush-fix.patch
# 632805
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.9.0-vbe-panelid-sanity.patch
# misc
#patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.9.0-vbe-insanity.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.9.0-classic-default-mode.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.9.0-qxl-fallback.patch

# Backports from master

patch -p0 --verbose -i ${SB_PATCHDIR}/xserver-1.9.0-force-hal-disable.patch
if [ "${SB_ZW}" = "YES" ] ;then
  patch -p1 --verbose -z .zap-warning -i ${SB_PATCHDIR}/xserver-zap-warning.patch
fi

set +e +o pipefail
