
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/x11.startwithblackscreen.diff.gz | patch -p1 --verbose || exit 1
#zcat ${SB_PATCHDIR}/xorgconfig.diff.gz | patch -p1 --verbose || exit 1
#zcat ${SB_PATCHDIR}/xorg-server.dpi.diff.gz | patch -p1 --verbose || exit 1

# Patches from Fedora
# OpenGL compositing manager feature/optimization patches.
zcat ${SB_PATCHDIR}/xorg-x11-server-1.1.0-no-move-damage.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.4.99-dont-backfill-bg-none.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-bg-none-root.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.4.99-pic-libxf86config.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-projector-fb-size.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.4.99-alloca-poison.patch.gz | patch -p1 --verbose || exit 1
# This really could be done prettier.
zcat ${SB_PATCHDIR}/xserver-1.4.99-ssh-isnt-local.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-bad-fbdev-thats-mine.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.4.99-endian.patch.gz | patch -p1 --verbose || exit 1

# force mode debugging on for randr 1.2 drivers
zcat ${SB_PATCHDIR}/xserver-1.5.1-mode-debug.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.5.99.3-dmx-xcalloc.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.5.99.902-sod-off-poulsbo.patch.gz | patch -p1 --verbose || exit 1

# don't build the (broken) acpi code
zcat ${SB_PATCHDIR}/xserver-1.6.0-less-acpi-brokenness.patch.gz | patch -p1 --verbose || exit 1

# https://bugs.freedesktop.org/show_bug.cgi?id=20087
zcat ${SB_PATCHDIR}/xserver-1.5.99.902-vnc.patch.gz | patch -p1 --verbose || exit 1

# Make autoconfiguration chose nouveau driver for NVIDIA GPUs
zcat ${SB_PATCHDIR}/xserver-1.5.99.902-nouveau.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.6.0-primary.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.6.0-xinerama-cursors.patch.gz | patch -p1 --verbose || exit 1
# http://bugs.freedesktop.org/show_bug.cgi?id=20557
zcat ${SB_PATCHDIR}/xserver-1.6.0-xinerama-crashes.patch.gz | patch -p1 --verbose || exit 1

# ajax needs to upstream this
zcat ${SB_PATCHDIR}/xserver-1.6.0-displayfd.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.6.0-restore-zap.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.6.0-no-i810.patch.gz | patch -p1 --verbose || exit 1

if [ "${SB_ZW}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xserver-1.5.99.902-zap-warning.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${SB_HAL}" != "YES" ] ;then
  # Fix dbus/hal disable-config configure parameters do not working
  zcat ${SB_PATCHDIR}/xserver-1.5.99.902-force-hal-disable.patch.gz | patch -p0 --verbose || exit 1
fi
