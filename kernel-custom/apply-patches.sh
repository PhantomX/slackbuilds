#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
DRYRUN=${DRYRUN:-NO}

if [ "${DRYRUN}" = "YES" ] ; then
  DRYRUN_OPT="--dry-run"
fi

if [ "${VERBOSE}" = "YES" ] ; then
  VERBOSE_OPT="--verbose"
fi

if [ "${SVERBOSE}" = "YES" ] ; then
  set -o xtrace
fi

PATCHCOM="patch ${DRYRUN_OPT} -p1 -F1 -s ${VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

ApplyOptionalPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  case "${patch}" in
  *.bz2) local C=$(bzcat ${SB_PATCHDIR}/${patch} | wc -l | awk '{print $1}') ;;
  *.gz) local C=$(zcat ${SB_PATCHDIR}/${patch} | wc -l | awk '{print $1}') ;;
  *) local C=$(wc -l ${SB_PATCHDIR}/${patch} | awk '{print $1}') ;;
  esac
  if [ "${C}" -gt 9 ]; then
    ApplyPatch ${patch} ${1+"$@"}
  fi
}

ApplyOptionalPatch git-linus.diff

# This patch adds a "make nonint_oldconfig" which is non-interactive and
# also gives a list of missing options at the end. Useful for automated
# builds (as used in the buildsystem).
#ApplyPatch linux-2.6-build-nonintconfig.patch

ApplyPatch linux-2.6-makefile-after_link.patch

#
# misc small stuff to make things compile
#
ApplyOptionalPatch linux-2.6-compile-fixes.patch.gz

# revert patches from upstream that conflict or that we get via other means
ApplyOptionalPatch linux-2.6-upstream-reverts.patch -R

ApplyOptionalPatch linux-2.6-hotfixes.patch

# Roland's utrace ptrace replacement.
ApplyPatch linux-2.6-utrace-revert-make-ptrace-functions-static.patch
ApplyPatch linux-2.6-tracehook.patch
ApplyPatch linux-2.6-utrace.patch
ApplyPatch linux-2.6-utrace-ptrace.patch

# vm patches

# Architecture patches
# x86(-64)
# Add K10 and native cpu optimization support
ApplyPatch linux-2.6-add-cpu-optimizations.patch
# Restore reliable stack backtraces
ApplyPatch x86-dumpstack-correct-stack-dump-info-when-frame-pointer-is-available.patch

#
# Intel IOMMU
#

#
# Exec shield
#
ApplyPatch linux-2.6-i386-nx-emulation.patch
ApplyPatch linux-2.6-32bit-mmap-exec-randomization.patch

#
# bugfixes to drivers and filesystems
#

ApplyPatch remount-no-shrink-dcache.patch

# reisefs
ApplyPatch reiserfs-force-inode-evictions-before-umount-to-avoid-crash.patch

# ext4

# xfs

# btrfs

# cifs

# NFSv4

# USB

# WMI

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch.gz
ApplyPatch linux-2.6-acpi-video-dos.patch
ApplyPatch acpi-ec-add-delay-before-write.patch
ApplyPatch linux-2.6-acpi-debug-infinite-loop.patch
# list acpi fixed events at /proc/acpi/fixed_events
ApplyPatch acpi-add-proc-event-regs.patch

# Various low-impact patches to aid debugging.
ApplyPatch linux-2.6-debug-sizeof-structs.patch
ApplyPatch linux-2.6-debug-taint-vm.patch
## try to find out what is breaking acpi-cpufreq
ApplyPatch linux-2.6-debug-vm-would-have-oomkilled.patch
ApplyPatch linux-2.6-debug-always-inline-kzalloc.patch.gz

#
# PCI
#
# disable message signaled interrupts
ApplyPatch linux-2.6-defaults-pci_no_msi.patch
ApplyPatch linux-2.6-defaults-pci_use_crs.patch
# enable ASPM by default on hardware we expect to work
ApplyPatch linux-2.6-defaults-aspm.patch.gz
ApplyPatch pci-pcie-links-may-not-get-configured-for-aspm-under-powersave-mode.patch
ApplyPatch pci-enable-aspm-state-clearing-regardless-of-policy.patch
# Fix breakage of PCI network adapter names on older Dell systems
ApplyPatch x86-pci-preserve-existing-pci-bfsort-whitelist-for-dell-systems.patch

#ApplyPatch ima-allow-it-to-be-completely-disabled-and-default-off.patch

#
# SCSI Bits.
#

# ALSA
ApplyPatch hda_intel-prealloc-4mb-dmabuffer.patch

# block/bio
#

# Networking

# Misc fixes
# The input layer spews crap no-one cares about.
ApplyPatch linux-2.6-input-kill-stupid-messages.patch

# stop floppy.ko from autoloading during udev...
ApplyPatch die-floppy-die.patch

ApplyPatch linux-2.6.30-no-pcspkr-modalias.patch.gz

# Allow to use 480600 baud on 16C950 UARTs
ApplyPatch linux-2.6-serial-460800.patch

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch linux-2.6-silence-noise.patch

# Make fbcon not show the penguins with 'quiet'
ApplyPatch linux-2.6-silence-fbcon-logo.patch.gz

# Changes to upstream defaults.
# Turns pnpbios off by default, useful, since pnpbios
# is know to cause problems (TTL: forever)
ApplyPatch pnp-pnpbios-off-by-default.patch

ApplyPatch pnp-isapnp-async-init.patch

# libata

#
# VM related fixes.
#

# /dev/crash driver.
ApplyPatch linux-2.6-crash-driver.patch

# crypto/

# Assorted Virt Fixes
ApplyPatch fix_xen_guest_on_old_EC2.patch

# DRM core
ApplyPatch drm-vblank-events-fix-hangs.patch

# Nouveau DRM
ApplyPatch drm-ttm-move-notify.patch
ApplyOptionalPatch drm-nouveau-fixes.patch
ApplyOptionalPatch drm-nouveau-updates.patch

# Intel DRM
ApplyOptionalPatch drm-intel-next.patch
ApplyPatch drm-intel-big-hammer.patch
ApplyPatch drm-intel-make-lvds-work.patch
ApplyPatch linux-2.6-intel-iommu-igfx.patch
ApplyPatch drm-intel-edp-fixes.patch
ApplyPatch drm-i915-fix-pipelined-fencing.patch
ApplyPatch drm-intel-eeebox-eb1007-quirk.patch
ApplyPatch drm-intel-restore-mode.patch

# linux1394 git patches
# apply if non-empty
#ApplyOptionalPatch linux-2.6-firewire-git-update.patch
#ApplyOptionalPatch linux-2.6-firewire-git-pending.patch.gz

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch

# V4L/DVB updates/fixes/experimental drivers
ApplyPatch cx88-Fix-HVR4000-IR-keymap.patch -R
ApplyOptionalPatch linux-2.6-v4l-dvb-fixes.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-update.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-experimental.patch

# Patches headed upstream
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch neuter_intel_microcode_load.patch

# various fixes for Apple and EFI
ApplyPatch apple_backlight.patch
ApplyPatch efifb_update.patch
ApplyPatch acpi_reboot.patch

# Runtime PM
#ApplyPatch linux-2.6-usb-pci-autosuspend.patch
#ApplyPatch linux-2.6-enable-more-pci-autosuspend.patch

# rhbz#605888
ApplyPatch dmar-disable-when-ricoh-multifunction.patch

# rhbz#691888
ApplyPatch printk-do-not-mangle-valid-userspace-syslog-prefixes.patch

ApplyPatch scsi-sd-downgrade-caching-printk-from-error-to-notice.patch

#rhbz 668231
ApplyPatch linux-2.6-netconsole-deadlock.patch

# CVE-2011-1581
ApplyPatch bonding-incorrect-tx-queue-offset.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
