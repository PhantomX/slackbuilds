
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/x11.startwithblackscreen.diff.gz | patch -p1 --verbose
#zcat ${SB_PATCHDIR}/xorgconfig.diff.gz | patch -p1 --verbose
#zcat ${SB_PATCHDIR}/xorg-server.dpi.diff.gz | patch -p1 --verbose

# Patches from Fedora
zcat ${SB_PATCHDIR}/xserver-1.5.0-bg-none-root.patch.gz | patch -p1 --verbose

zcat ${SB_PATCHDIR}/xserver-1.4.99-pic-libxf86config.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.7.4-z-now.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.5.0-projector-fb-size.patch.gz | patch -p1 --verbose

# This really could be done prettier.
zcat ${SB_PATCHDIR}/xserver-1.4.99-ssh-isnt-local.patch.gz | patch -p1 --verbose

# force mode debugging on for randr 1.2 drivers
zcat ${SB_PATCHDIR}/xserver-1.5.1-mode-debug.patch.gz | patch -p1 --verbose

# don't build the (broken) acpi code
zcat ${SB_PATCHDIR}/xserver-1.6.0-less-acpi-brokenness.patch.gz | patch -p1 --verbose

# Make autoconfiguration chose nouveau driver for NVIDIA GPUs
zcat ${SB_PATCHDIR}/xserver-1.6.1-nouveau.patch.gz | patch -p1 --verbose

# ajax needs to upstream this
zcat ${SB_PATCHDIR}/xserver-1.6.0-displayfd.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.6.99-randr-error-debugging.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.6.99-right-of.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.6.99-default-modes.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.7.0-randr-gamma-restore.patch.gz | patch -p1 --verbose

zcat ${SB_PATCHDIR}/xserver-1.7.0-glx-versioning.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.7.1-multilib.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.7.1-gamma-kdm-fix.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.7.1-libcrypto.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xserver-1.7.1-glx14-swrast.patch.gz | patch -p1 --verbose

zcat ${SB_PATCHDIR}/xserver-1.7.3-exa-master.patch.gz | patch -p1 --verbose

zcat ${SB_PATCHDIR}/xserver-1.7.3-no-free-on-abort.patch.gz | patch -p1 --verbose

# 558613
zcat ${SB_PATCHDIR}/xserver-1.7.4-qxl-autoconfig.patch.gz | patch -p1 --verbose
# 516918
zcat ${SB_PATCHDIR}/xserver-1.7.4-dpms-timeouts.patch.gz | patch -p1 --verbose

# 543647
zcat ${SB_PATCHDIR}/xserver-1.7.4-owner-events.patch.gz | patch -p1 --verbose

zcat ${SB_PATCHDIR}/xserver-1.7.5-exa-mixed.patch.gz | patch -p1 --verbose

if [ "${SB_ZW}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xserver-1.7.3.902-zap-warning.patch.gz | patch -p1 --verbose
fi

if [ "${SB_HAL}" != "YES" ] ;then
  # Fix dbus/hal disable-config configure parameters do not working
  zcat ${SB_PATCHDIR}/xserver-1.5.99.902-force-hal-disable.patch.gz | patch -p0 --verbose
fi

set +e +o pipefail
