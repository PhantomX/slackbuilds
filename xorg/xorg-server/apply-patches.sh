
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/x11.startwithblackscreen.diff.gz | patch -p1 --verbose
#zcat ${SB_PATCHDIR}/xorgconfig.diff.gz | patch -p1 --verbose
#zcat ${SB_PATCHDIR}/xorg-server.dpi.diff.gz | patch -p1 --verbose

# Patches from Fedora
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.5.0-bg-none-root.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.8.0.901-pic-libxf86config.patch
zcat ${SB_PATCHDIR}/xserver-1.7.4-z-now.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.5.0-projector-fb-size.patch.gz | patch -p1 --verbose

# This really could be done prettier.
zcat ${SB_PATCHDIR}/xserver-1.4.99-ssh-isnt-local.patch.gz | patch -p1 --verbose

# force mode debugging on for randr 1.2 drivers
zcat ${SB_PATCHDIR}/xserver-1.5.1-mode-debug.patch.gz | patch -p1 --verbose

# don't build the (broken) acpi code
zcat ${SB_PATCHDIR}/xserver-1.6.0-less-acpi-brokenness.patch.gz | patch -p1 --verbose

# Make autoconfiguration chose nouveau driver for NVIDIA GPUs
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.1-nouveau.patch

# ajax needs to upstream this
zcat ${SB_PATCHDIR}/xserver-1.6.0-displayfd.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.6.99-randr-error-debugging.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.6.99-right-of.patch.gz | patch -p1 --verbose
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.99-default-modes.patch
#zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.7.0-randr-gamma-restore.patch

zcat ${SB_PATCHDIR}/xserver-1.7.1-multilib.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.7.1-gamma-kdm-fix.patch.gz | patch -p1 --verbose

# Backports from master
#patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.8.0-swap-fixes.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=27767 (plus related
# pieces needed backported from master)
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.8.0-resource-accounting.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.8-no-connected-outputs.patch

patch -p0 --verbose -i ${SB_PATCHDIR}/xserver-1.8.0-force-hal-disable.patch
if [ "${SB_ZW}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xserver-1.7.3.902-zap-warning.patch.gz | patch -p1 --verbose
fi

set +e +o pipefail
