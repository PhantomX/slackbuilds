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
  local C=$(zcat ${SB_PATCHDIR}/${patch} | wc -l | awk '{print $1}')
  if [ "${C}" -gt 9 ]; then
    ApplyPatch ${patch} ${1+"$@"}
  fi
}

# Adds layer 7 iptables support
#ApplyPatch kernel-2.6.25-layer7-2.20.patch.gz | ${PATCHCOM}

#ApplyPatch acpi-dsdt-initrd-v0.9c-2.6.28.patch.gz
#ApplyPatch acpi-dsdt-initrd-v0.9c-fixes.patch.gz

# This patch adds a "make nonint_oldconfig" which is non-interactive and
# also gives a list of missing options at the end. Useful for automated
# builds (as used in the buildsystem).
ApplyPatch linux-2.6-build-nonintconfig.patch.gz

ApplyPatch linux-2.6-makefile-after_link.patch.gz

#
# misc small stuff to make things compile
#
ApplyOptionalPatch linux-2.6-compile-fixes.patch.gz

# revert patches from upstream that conflict or that we get via other means
ApplyOptionalPatch linux-2.6-upstream-reverts.patch.gz -R

ApplyOptionalPatch git-cpufreq.patch.gz

ApplyOptionalPatch linux-2.6-hotfixes.patch.gz

# Roland's utrace ptrace replacement.
ApplyPatch linux-2.6-tracehook.patch.gz
ApplyPatch linux-2.6-utrace.patch.gz

ApplyPatch sched-introduce-SCHED_RESET_ON_FORK-scheduling-policy-flag.patch.gz

# vm patches

ApplyPatch disable-stackprotector-all.patch.gz
# enable sysrq-c on all kernels, not only kexec
#ApplyPatch linux-2.6-sysrq-c.patch.gz

# Architecture patches
# x86(-64)
ApplyPatch via-hwmon-temp-sensor.patch.gz
ApplyPatch linux-2.6-dell-laptop-rfkill-fix.patch.gz

#
# Intel IOMMU
#
# Quiesce USB host controllers before setting up the IOMMU
ApplyPatch linux-2.6-die-closed-source-bios-muppets-die.patch.gz
# Some performance fixes, unify hardware/software passthrough support, and
# most importantly: notice when the BIOS points us to a region that returns
# all 0xFF, and claims that there's an IOMMU there.
ApplyPatch linux-2.6-intel-iommu-updates.patch.gz
ApplyPatch linux-2.6-iommu-at-zero.patch.gz

#
# Exec shield
#
ApplyPatch linux-2.6-execshield.patch.gz

#
# bugfixes to drivers and filesystems
#

# ext4

# xfs

# btrfs
ApplyPatch linux-2.6-btrfs-upstream.patch.gz

# cifs

# NFSv4
ApplyPatch linux-2.6-nfsd4-proots.patch.gz
ApplyPatch linux-2.6-nfs4-ver4opt.patch.gz
ApplyPatch linux-2.6-nfs4-callback-hidden.patch.gz

# USB
ApplyPatch linux-2.6-driver-level-usb-autosuspend.diff.gz
ApplyPatch linux-2.6-qcserial-autosuspend.diff.gz
ApplyPatch linux-2.6-bluetooth-autosuspend.diff.gz
ApplyPatch linux-2.6-usb-uvc-autosuspend.diff.gz

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch.gz
ApplyPatch linux-2.6-acpi-video-dos.patch.gz

# Various low-impact patches to aid debugging.
ApplyPatch linux-2.6-debug-sizeof-structs.patch.gz
ApplyPatch linux-2.6-debug-nmi-timeout.patch.gz
ApplyPatch linux-2.6-debug-taint-vm.patch.gz
ApplyPatch linux-2.6-debug-spinlock-taint.patch.gz
## try to find out what is breaking acpi-cpufreq
ApplyPatch linux-2.6-debug-vm-would-have-oomkilled.patch.gz
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
ApplyPatch linux-2.6-alsa-improve-hda-powerdown.patch.gz
ApplyPatch hda_intel-prealloc-4mb-dmabuffer.patch.gz
ApplyPatch alsa-tell-user-that-stream-to-be-rewound-is-suspended.patch.gz

# block/bio
#

# Filesystem patches.

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
ApplyPatch linux-2.6-serial-460800.patch.gz

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch linux-2.6-silence-noise.patch.gz
ApplyPatch linux-2.6.30-hush-rom-warning.patch.gz

# Make fbcon not show the penguins with 'quiet'
ApplyPatch linux-2.6-silence-fbcon-logo.patch.gz

# Changes to upstream defaults.

# back-port scan result aging patches
#ApplyPatch linux-2.6-mac80211-age-scan-results-on-resume.patch.gz

# libata
# Make it possible to identify non-hotplug SATA ports
ApplyPatch linux-2.6-ahci-export-capabilities.patch.gz

#
# VM related fixes.
#

# /dev/crash driver.
ApplyPatch linux-2.6-crash-driver.patch.gz

# Determine cacheline sizes in a generic manner.
ApplyPatch linux-2.6-pci-cacheline-sizing.patch.gz

# cpuidle: Fix the menu governor to boost IO performance
ApplyPatch linux-2.6.31-cpuidle-faster-io.patch.gz

# http://www.lirc.org/
ApplyPatch lirc-2.6.31.patch.gz
# tell usbhid to ignore all imon devices (sent upstream 2009.07.31)
ApplyPatch hid-ignore-all-recent-imon-devices.patch.gz
# enable IR receiver on Hauppauge HD PVR (v4l-dvb merge pending)
ApplyPatch hdpvr-ir-enable.patch.gz

# Add kernel KSM support
ApplyPatch linux-2.6-ksm.patch.gz
ApplyPatch linux-2.6-ksm-updates.patch.gz
ApplyPatch linux-2.6-ksm-fix-munlock.patch.gz
# Optimize KVM for KSM support
ApplyPatch linux-2.6-ksm-kvm.patch.gz

# Assorted Virt Fixes
#ApplyPatch linux-2.6-xen-stack-protector-fix.patch.gz
ApplyPatch linux-2.6-virtio_blk-revert-QUEUE_FLAG_VIRT-addition.patch.gz
ApplyPatch linux-2.6-xen-fix-is_disconnected_device-exists_disconnected_device.patch.gz
ApplyPatch linux-2.6-xen-improvement-to-wait_for_devices.patch.gz
ApplyPatch linux-2.6-xen-increase-device-connection-timeout.patch.gz
ApplyPatch linux-2.6-virtio_blk-add-support-for-cache-flush.patch.gz

# Fix block I/O errors in KVM
ApplyPatch linux-2.6-block-silently-error-unsupported-empty-barriers-too.patch.gz

# Nouveau DRM + drm fixes
ApplyPatch kms-offb-handoff.patch.gz
ApplyPatch drm-next-ea1495a6.patch.gz
ApplyPatch drm-radeon-agp-font-fix.patch.gz
ApplyPatch drm-radeon-fix-ring-rmw-issue.patch.gz
ApplyPatch drm-r600-lenovo-w500-fix.patch.gz
ApplyPatch drm-conservative-fallback-modes.patch.gz
ApplyPatch drm-radeon-fix-agp-resume.patch.gz

ApplyPatch drm-nouveau.patch.gz
ApplyPatch drm-i915-resume-force-mode.patch.gz
ApplyOptionalPatch drm-intel-next.patch.gz
ApplyPatch drm-intel-no-tv-hotplug.patch.gz

# VGA arb + drm
ApplyPatch linux-2.6-vga-arb.patch.gz
ApplyPatch drm-vga-arb.patch.gz
ApplyPatch drm-radeon-kms-arbiter-return-ignore.patch.gz

# linux1394 git patches
#ApplyPatch linux-2.6-firewire-git-update.patch.gz
#ApplyOptionalPatch linux-2.6-firewire-git-pending.patch.gz

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch.gz

# V4L/DVB updates/fixes/experimental drivers
#ApplyPatch linux-2.6-v4l-dvb-fixes.patch.gz
#ApplyPatch linux-2.6-v4l-dvb-update.patch.gz
#ApplyPatch linux-2.6-v4l-dvb-experimental.patch.gz
#ApplyPatch linux-2.6-revert-dvb-net-kabi-change.patch.gz
ApplyPatch v4l-dvb-fix-cx25840-firmware-loading.patch.gz

# Patches headed upstream
ApplyPatch linux-2.6-rtc-show-hctosys.patch.gz
ApplyPatch linux-2.6-rfkill-all.patch.gz
ApplyPatch linux-2.6-selinux-module-load-perms.patch.gz

# make perf counter API available to userspace (#527264)
ApplyPatch perf-make-perf-counter-h-available-to-userspace.patch.gz

ApplyPatch improve-resource-counter-scalability.patch.gz

# fix perf for sysprof
ApplyPatch perf-events-fix-swevent-hrtimer-sampling.patch.gz
ApplyPatch perf-events-dont-generate-events-for-the-idle-task.patch.gz

# Fix oops in padlock
ApplyPatch crypto-via-padlock-fix-nano-aes.patch.gz

# tg3 fixes (#527209)
ApplyPatch tg3-01-delay-mdio-bus-init-until-fw-finishes.patch.gz
ApplyPatch tg3-02-fix-tso-test-against-wrong-flags-var.patch.gz
ApplyPatch tg3-03-fix-57780-asic-rev-pcie-link-receiver-errors.patch.gz
ApplyPatch tg3-04-prevent-tx-bd-corruption.patch.gz
ApplyPatch tg3-05-assign-flags-to-fixes-in-start_xmit_dma_bug.patch.gz
ApplyPatch tg3-06-fix-5906-transmit-hangs.patch.gz

set +e
