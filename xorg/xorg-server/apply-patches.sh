
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/x11.startwithblackscreen.diff.gz | patch -p1 --verbose
#zcat ${SB_PATCHDIR}/xorgconfig.diff.gz | patch -p1 --verbose
#zcat ${SB_PATCHDIR}/xorg-server.dpi.diff.gz | patch -p1 --verbose

# Patches from Fedora
#patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.5.0-bg-none-root.patch

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
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.6.99-right-of.patch
#zcat ${SB_PATCHDIR}/xserver-1.6.99-hush-prerelease-warning.patch.gz | patch -p1 --verbose

# misc
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.9.0-qxl-fallback.patch

patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.10-pointer-barriers.patch
#patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.10-vbe-malloc.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.10-glx-pixmap-crash.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/xserver-1.10-bg-none-revert.patch

# Backports from master

patch -p0 --verbose -i ${SB_PATCHDIR}/xserver-1.9.0-force-hal-disable.patch
if [ "${SB_ZW}" = "YES" ] ;then
  patch -p1 --verbose -z .zap-warning -i ${SB_PATCHDIR}/xserver-zap-warning.patch
fi

set +e +o pipefail
