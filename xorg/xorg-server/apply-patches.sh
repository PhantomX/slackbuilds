
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/x11.startwithblackscreen.diff.gz | patch -p1 --verbose || exit 1
#zcat ${SB_PATCHDIR}/xorgconfig.diff.gz | patch -p1 --verbose || exit 1
#zcat ${SB_PATCHDIR}/xorg-server.dpi.diff.gz | patch -p1 --verbose || exit 1

# Patches from Fedora
zcat ${SB_PATCHDIR}/xserver-1.5.0-bg-none-root.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.4.99-pic-libxf86config.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-projector-fb-size.patch.gz | patch -p1 --verbose || exit 1

# This really could be done prettier.
zcat ${SB_PATCHDIR}/xserver-1.4.99-ssh-isnt-local.patch.gz | patch -p1 --verbose || exit 1

# force mode debugging on for randr 1.2 drivers
zcat ${SB_PATCHDIR}/xserver-1.5.1-mode-debug.patch.gz | patch -p1 --verbose || exit 1

# don't build the (broken) acpi code
zcat ${SB_PATCHDIR}/xserver-1.6.0-less-acpi-brokenness.patch.gz | patch -p1 --verbose || exit 1

# Make autoconfiguration chose nouveau driver for NVIDIA GPUs
zcat ${SB_PATCHDIR}/xserver-1.6.1-nouveau.patch.gz | patch -p1 --verbose || exit 1

# ajax needs to upstream this
zcat ${SB_PATCHDIR}/xserver-1.6.0-displayfd.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.6.99-randr-error-debugging.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.6.99-right-of.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.6.99-default-modes.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.7.0-randr-gamma-restore.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.7.0-glx-versioning.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.7.0-exa-fix-mixed.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.7.1-multilib.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.7.1-window-pictures.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.7.1-gamma-kdm-fix.patch.gz | patch -p1 --verbose || exit 1

if [ "${SB_ZW}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xserver-1.5.99.902-zap-warning.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${SB_HAL}" != "YES" ] ;then
  # Fix dbus/hal disable-config configure parameters do not working
  zcat ${SB_PATCHDIR}/xserver-1.5.99.902-force-hal-disable.patch.gz | patch -p0 --verbose || exit 1
fi
