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

# Adds layer 7 iptables support
#ApplyPatch kernel-2.6.25-layer7-2.20.patch.gz | ${PATCHCOM}

#ApplyPatch acpi-dsdt-initrd-v0.9c-2.6.28.patch.gz
#ApplyPatch acpi-dsdt-initrd-v0.9c-fixes.patch.gz

ApplyOptionalPatch git-linus.diff

# This patch adds a "make nonint_oldconfig" which is non-interactive and
# also gives a list of missing options at the end. Useful for automated
# builds (as used in the buildsystem).
ApplyPatch linux-2.6-build-nonintconfig.patch

ApplyPatch linux-2.6-makefile-after_link.patch

#
# misc small stuff to make things compile
#
ApplyOptionalPatch linux-2.6-compile-fixes.patch.gz

# revert patches from upstream that conflict or that we get via other means
ApplyOptionalPatch linux-2.6-upstream-reverts.patch -R

ApplyOptionalPatch git-cpufreq.patch.gz
#ApplyPatch git-bluetooth.patch

ApplyOptionalPatch linux-2.6-hotfixes.patch

# Roland's utrace ptrace replacement.
ApplyPatch linux-2.6-tracehook.patch
ApplyPatch linux-2.6-utrace.patch
ApplyPatch linux-2.6-utrace-ptrace.patch

# vm patches

# enable sysrq-c on all kernels, not only kexec
#ApplyPatch linux-2.6-sysrq-c.patch.gz

# Architecture patches
# x86(-64)
ApplyPatch linux-2.6-x86-cfi_sections.patch

#
# Intel IOMMU
#

#
# Exec shield
#
ApplyPatch linux-2.6-execshield.patch

#
# bugfixes to drivers and filesystems
#

# ext4

# xfs

# btrfs
ApplyPatch btrfs-prohibit-a-operation-of-changing-acls-mask-when-noacl-mount-option-is-used.patch


# cifs

# NFSv4

# USB
#ApplyPatch linux-2.6-driver-level-usb-autosuspend.diff
#ApplyPatch linux-2.6-enable-btusb-autosuspend.patch
#ApplyPatch linux-2.6-usb-uvc-autosuspend.diff.gz
ApplyPatch linux-2.6-usb-wwan-update.patch

# WMI

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch.gz
ApplyPatch linux-2.6-acpi-video-dos.patch
ApplyPatch linux-2.6-acpi-video-export-edid.patch
ApplyPatch acpi-ec-add-delay-before-write.patch

ApplyPatch linux-2.6-acpi-sleep-live-sci-live.patch

# Various low-impact patches to aid debugging.
ApplyPatch linux-2.6-debug-sizeof-structs.patch
ApplyPatch linux-2.6-debug-nmi-timeout.patch
ApplyPatch linux-2.6-debug-taint-vm.patch
## try to find out what is breaking acpi-cpufreq
ApplyPatch linux-2.6-debug-vm-would-have-oomkilled.patch
ApplyPatch linux-2.6-debug-always-inline-kzalloc.patch.gz

#
# PCI
#
# disable message signaled interrupts
ApplyPatch linux-2.6-defaults-pci_no_msi.patch
# enable ASPM by default on hardware we expect to work
ApplyPatch linux-2.6-defaults-aspm.patch.gz

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

# Get away from having to poll Toshibas
#ApplyPatch linux-2.6-input-fix-toshiba-hotkeys.patch.gz

ApplyPatch linux-2.6.30-no-pcspkr-modalias.patch.gz

ApplyPatch linux-2.6-input-hid-quirk-egalax.patch
ApplyPatch thinkpad-acpi-add-x100e.patch
ApplyPatch thinkpad-acpi-fix-backlight.patch

# Allow to use 480600 baud on 16C950 UARTs
ApplyPatch linux-2.6-serial-460800.patch

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch linux-2.6-silence-noise.patch.gz
ApplyPatch pci-hush-rom-warning.patch

# Make fbcon not show the penguins with 'quiet'
ApplyPatch linux-2.6-silence-fbcon-logo.patch.gz

# Changes to upstream defaults.

# libata

#
# VM related fixes.
#

# /dev/crash driver.
ApplyPatch linux-2.6-crash-driver.patch

# Cantiga chipset b0rkage
ApplyPatch linux-2.6-cantiga-iommu-gfx.patch

# crypto/

# Add async hash testing (a8f1a05)
ApplyPatch crypto-add-async-hash-testing.patch

# http://www.lirc.org/
ApplyPatch lirc-2.6.33.patch
# enable IR receiver on Hauppauge HD PVR (v4l-dvb merge pending)
ApplyPatch hdpvr-ir-enable.patch

# Add kernel KSM support
# Optimize KVM for KSM support
#ApplyPatch linux-2.6-ksm-kvm.patch

# Assorted Virt Fixes
ApplyPatch virtqueue-wrappers.patch
ApplyPatch virt_console-rollup.patch
ApplyPatch fix_xen_guest_on_old_EC2.patch

ApplyPatch drm-next.patch
ApplyPatch drm-revert-drm-fbdev-rework-output-polling-to-be-back-in-core.patch
ApplyPatch revert-drm-kms-toggle-poll-around-switcheroo.patch
ApplyPatch drm-i915-fix-edp-panels.patch
ApplyPatch i915-fix-crt-hotplug-regression.patch

# Nouveau DRM + drm fixes
ApplyPatch drm-nouveau-drm-fixed-header.patch
ApplyPatch drm-intel-big-hammer.patch
ApplyOptionalPatch drm-intel-next.patch
ApplyPatch drm-intel-make-lvds-work.patch
ApplyPatch linux-2.6-intel-iommu-igfx.patch


# linux1394 git patches
# apply if non-empty
#ApplyOptionalPatch linux-2.6-firewire-git-update.patch
#ApplyOptionalPatch linux-2.6-firewire-git-pending.patch.gz

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch

# V4L/DVB updates/fixes/experimental drivers
ApplyOptionalPatch linux-2.6-v4l-dvb-fixes.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-update.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-experimental.patch

ApplyPatch linux-2.6-v4l-dvb-gspca-fixes.patch

ApplyPatch linux-2.6-v4l-dvb-add-lgdt3304-support.patch
ApplyPatch linux-2.6-v4l-dvb-add-kworld-a340-support.patch

ApplyPatch linux-2.6-phylib-autoload.patch

# Patches headed upstream
ApplyPatch add-appleir-usb-driver.patch
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch neuter_intel_microcode_load.patch

# Refactor UserModeHelper code & satisfy abrt recursion check request
#ApplyPatch linux-2.6-umh-refactor.patch

# rhbz#533746
ApplyPatch ssb_check_for_sprom.patch

ApplyPatch quiet-prove_RCU-in-cgroups.patch

set +e +o pipefail +o xtrace
