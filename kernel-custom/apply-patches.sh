#!/bin/sh

set -e

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
ApplyOptionalPatch linux-2.6-upstream-reverts.patch.gz -R

ApplyOptionalPatch git-cpufreq.patch.gz

ApplyOptionalPatch linux-2.6-hotfixes.patch.gz

# Roland's utrace ptrace replacement.
ApplyPatch linux-2.6-tracehook.patch
ApplyPatch linux-2.6-utrace.patch
ApplyPatch linux-2.6-utrace-ptrace.patch

# vm patches

# enable sysrq-c on all kernels, not only kexec
#ApplyPatch linux-2.6-sysrq-c.patch.gz

# Architecture patches
# x86(-64)
ApplyPatch via-hwmon-temp-sensor.patch
ApplyPatch linux-2.6-dell-laptop-rfkill-fix.patch.gz

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

# cifs

# NFSv4
ApplyPatch linux-2.6-nfsd4-proots.patch
ApplyPatch linux-2.6-nfs4-callback-hidden.patch.gz

# USB
ApplyPatch linux-2.6-driver-level-usb-autosuspend.diff
ApplyPatch linux-2.6-enable-btusb-autosuspend.patch
ApplyPatch linux-2.6-usb-uvc-autosuspend.diff.gz

# WMI
ApplyPatch linux-2.6-autoload-wmi.patch
# autoload fixes
ApplyPatch wmi-check-find_guid-return-value-to-prevent-oops.patch
ApplyPatch wmi-survive-bios-with-duplicate-guids.patch

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch.gz
ApplyPatch linux-2.6-acpi-video-dos.patch.gz

# Various low-impact patches to aid debugging.
ApplyPatch linux-2.6-debug-sizeof-structs.patch
ApplyPatch linux-2.6-debug-nmi-timeout.patch.gz
ApplyPatch linux-2.6-debug-taint-vm.patch
ApplyPatch linux-2.6-debug-spinlock-taint.patch.gz
## try to find out what is breaking acpi-cpufreq
ApplyPatch linux-2.6-debug-vm-would-have-oomkilled.patch
ApplyPatch linux-2.6-debug-always-inline-kzalloc.patch.gz

#
# PCI
#
# disable message signaled interrupts
ApplyPatch linux-2.6-defaults-pci_no_msi.patch.gz
# enable ASPM by default on hardware we expect to work
ApplyPatch linux-2.6-defaults-aspm.patch.gz

#
# SCSI Bits.
#

# ALSA
# squelch hda_beep by default
ApplyPatch linux-2.6-defaults-alsa-hda-beep-off.patch.gz
ApplyPatch hda_intel-prealloc-4mb-dmabuffer.patch.gz

# block/bio
#

# Networking

# add ich9 lan
ApplyPatch linux-2.6-e1000-ich9.patch.gz

# Misc fixes
# The input layer spews crap no-one cares about.
ApplyPatch linux-2.6-input-kill-stupid-messages.patch.gz

# stop floppy.ko from autoloading during udev...
ApplyPatch die-floppy-die.patch.gz

# Get away from having to poll Toshibas
#ApplyPatch linux-2.6-input-fix-toshiba-hotkeys.patch.gz

ApplyPatch linux-2.6.30-no-pcspkr-modalias.patch.gz

# Allow to use 480600 baud on 16C950 UARTs
ApplyPatch linux-2.6-serial-460800.patch

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch linux-2.6-silence-noise.patch.gz
ApplyPatch linux-2.6.30-hush-rom-warning.patch.gz

# Make fbcon not show the penguins with 'quiet'
ApplyPatch linux-2.6-silence-fbcon-logo.patch.gz

# Changes to upstream defaults.

# back-port scan result aging patches
#ApplyPatch linux-2.6-mac80211-age-scan-results-on-resume.patch.gz

# libata

#
# VM related fixes.
#

# /dev/crash driver.
ApplyPatch linux-2.6-crash-driver.patch

# Determine cacheline sizes in a generic manner.
ApplyPatch linux-2.6-pci-cacheline-sizing.patch.gz

# http://www.lirc.org/
ApplyPatch lirc-2.6.32.patch
# enable IR receiver on Hauppauge HD PVR (v4l-dvb merge pending)
ApplyPatch hdpvr-ir-enable.patch

# Add kernel KSM support
# Optimize KVM for KSM support
#ApplyPatch linux-2.6-ksm-kvm.patch

# Assorted Virt Fixes
ApplyPatch linux-2.6-userspace_kvmclock_offset.patch

# Fix block I/O errors in KVM
#ApplyPatch linux-2.6-block-silently-error-unsupported-empty-barriers-too.patch.gz

# Nouveau DRM + drm fixes
ApplyPatch drm-radeon-fixes.patch
ApplyPatch drm-radeon-dp-support.patch
ApplyPatch drm-nouveau.patch.gz
ApplyPatch drm-intel-big-hammer.patch
# Some BIOSes don't clear the whole GTT, and it causes IOMMU faults
ApplyPatch linux-2.6-intel-agp-clear-gtt.patch

# linux1394 git patches
# apply if non-empty
#ApplyOptionalPatch linux-2.6-firewire-git-update.patch
#ApplyOptionalPatch linux-2.6-firewire-git-pending.patch.gz

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch

# V4L/DVB updates/fixes/experimental drivers
#ApplyOptionalPatch linux-2.6-v4l-dvb-fixes.patch
#ApplyOptionalPatch linux-2.6-v4l-dvb-update.patch
#ApplyOptionalPatch linux-2.6-v4l-dvb-experimental.patch

# Patches headed upstream
ApplyPatch linux-2.6-rfkill-all.patch

# Patches for -stable
ApplyPatch wmi-free-the-allocated-acpi-objects.patch
ApplyPatch wmi-check-wmi-get-event-data-return-value.patch

set +e
