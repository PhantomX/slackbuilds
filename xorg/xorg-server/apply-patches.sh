
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/x11.startwithblackscreen.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xorgconfig.diff.gz | patch -p1 --verbose || exit 1
#zcat ${SB_PATCHDIR}/xorg-server.dpi.diff.gz | patch -p1 --verbose || exit 1

# Patches from Fedora or Debian
zcat ${SB_PATCHDIR}/001_fedora_extramodes.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/121_only_switch_vt_when_active.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/135_rethrow_signals.patch.gz | patch -p1 --verbose || exit 1
# OpenGL compositing manager feature/optimization patches.
zcat ${SB_PATCHDIR}/xorg-x11-server-1.1.0-no-move-damage.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.4.99-dont-backfill-bg-none.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.2-exa-master-upgrade.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-bg-none-root.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-exa-master-fix-x11perf-crash.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.1-exa-fix-glyph-segfault.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.3-exa-fix-x-y-src-dst.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.3-exa-fix-composite-rects.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.3-exa-fix-unneeded-copies.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.4.99-pic-libxf86config.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-projector-fb-size.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.4.99-alloca-poison.patch.gz | patch -p1 --verbose || exit 1
# This really could be done prettier.
zcat ${SB_PATCHDIR}/xserver-1.4.99-ssh-isnt-local.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.1-xgi.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-bad-fbdev-thats-mine.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.4.99-endian.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-force-SwitchCoreKeyboard-for-evdev.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-hide-cursor.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xserver-1.5.0-edid-backport.patch.gz | patch -p1 --verbose || exit 1

# force mode debugging on for randr 1.2 drivers
zcat ${SB_PATCHDIR}/xserver-1.5.1-mode-debug.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.5.2-more-sanity-checks.patch.gz | patch -p1 --verbose || exit 1

# Bug 471221
zcat ${SB_PATCHDIR}/xserver-1.5.3-AEI-on-by-default.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/xserver-1.5.3-idletime-fix.patch.gz | patch -p1 --verbose || exit 1

# fix SBUS autodetection, from upstream git
# http://cgit.freedesktop.org/xorg/xserver/commit/?id=24e863b0eb6ff11010a14cfd252a39df87a09d0e
zcat ${SB_PATCHDIR}/xserver-1.5.2-sbusAutoDetection.patch.gz | patch -p1 --verbose || exit 1

if [ "${SB_HAL}" != "YES" ] ;then
  # Fix dbus/hal disable-config configure parameters do not working
  zcat ${SB_PATCHDIR}/xserver-1.5.3-force-hal-disable.patch.gz | patch -p0 --verbose || exit 1
fi
