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
ApplyPatch git-bluetooth.patch

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
ApplyPatch linux-2.6-dell-laptop-rfkill-fix.patch

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
ApplyPatch linux-2.6-btrfs-update.patch

# cifs

# NFSv4
ApplyPatch linux-2.6-nfs4-callback-hidden.patch.gz

# CPUFREQ
ApplyPatch linux-2.6-cpufreq-locking.patch

# USB
ApplyPatch linux-2.6-driver-level-usb-autosuspend.diff
ApplyPatch linux-2.6-enable-btusb-autosuspend.patch
ApplyPatch linux-2.6-usb-uvc-autosuspend.diff.gz
ApplyPatch linux-2.6-usb-wwan-update.patch

# WMI

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch.gz
ApplyPatch linux-2.6-acpi-video-dos.patch
ApplyPatch linux-2.6-acpi-video-export-edid.patch

ApplyPatch acpi-ec-add-delay-before-write.patch
ApplyPatch acpi-ec-allow-multibyte-access-to-ec.patch
ApplyPatch acpi-ec-limit-burst-to-64-bit.patch

# Various low-impact patches to aid debugging.
ApplyPatch linux-2.6-debug-sizeof-structs.patch
ApplyPatch linux-2.6-debug-nmi-timeout.patch
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
ApplyPatch hda_intel-prealloc-4mb-dmabuffer.patch.gz

# block/bio
#

# Networking

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
ApplyPatch linux-2.6.30-hush-rom-warning.patch

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

# http://www.lirc.org/
ApplyPatch lirc-2.6.33.patch
# enable IR receiver on Hauppauge HD PVR (v4l-dvb merge pending)
ApplyPatch hdpvr-ir-enable.patch

# Add kernel KSM support
# Optimize KVM for KSM support
#ApplyPatch linux-2.6-ksm-kvm.patch

# Assorted Virt Fixes
#ApplyPatch linux-2.6-userspace_kvmclock_offset.patch
ApplyPatch vhost_net-rollup.patch
ApplyPatch virt_console-rollup.patch
ApplyPatch virt_console-fix-race.patch
ApplyPatch virt_console-fix-fix-race.patch
ApplyPatch virt_console-rollup2.patch

# Fix block I/O errors in KVM
#ApplyPatch linux-2.6-block-silently-error-unsupported-empty-barriers-too.patch.gz

# fix x86-64 fbdev primary GPU selection
ApplyPatch linux-2.6-x86-64-fbdev-primary.patch

ApplyPatch drm-core-next.patch

# Nouveau DRM + drm fixes
ApplyPatch drm-radeon-evergreen.patch
# squash nouveau firmware into a single commit until it gets into linux-firmware
ApplyPatch drm-nouveau-abi16.patch
ApplyPatch drm-nouveau-updates.patch
ApplyPatch drm-nouveau-acpi-edid-fallback.patch
# pm broken on my thinkpad t60p - airlied
ApplyPatch drm-intel-big-hammer.patch
ApplyOptionalPatch drm-intel-next.patch
ApplyPatch drm-intel-make-lvds-work.patch
ApplyPatch drm-intel-acpi-populate-didl.patch

ApplyPatch linux-2.6-phylib-autoload.patch

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

ApplyPatch linux-2.6-v4l-dvb-rebase-gspca-to-latest.patch
ApplyPatch linux-2.6-v4l-dvb-gspca-fixes.patch

# Patches headed upstream
ApplyPatch linux-2.6-rfkill-all.patch

ApplyPatch add-appleir-usb-driver.patch

ApplyPatch neuter_intel_microcode_load.patch

# Refactor UserModeHelper code & satisfy abrt recursion check request
ApplyPatch linux-2.6-umh-refactor.patch

# rhbz#533746
ApplyPatch ssb_check_for_sprom.patch

# backport iwlwifi fixes (thanks, sgruszka!) -- drop when stable catches-up
ApplyPatch iwlwifi-reset-card-during-probe.patch

# make b43 gracefully switch to PIO mode in event of DMA errors
ApplyPatch b43_-Allow-PIO-mode-to-be-selected-at-module-load.patch
ApplyPatch b43_-fall-back-gracefully-to-PIO-mode-after-fatal-DMA-errors.patch

ApplyPatch libata-fix-accesses-at-LBA28-boundary.patch

# patches from Intel to address intermittent firmware failures with iwlagn
ApplyPatch mac80211_-tear-down-all-agg-queues-when-restart_reconfig-hw.patch
ApplyPatch iwlwifi_-check-for-aggregation-frame-and-queue.patch
ApplyPatch iwlwifi_-clear-all-tx-queues-when-firmware-ready.patch
ApplyPatch iwlwifi_-clear-all-the-stop_queue-flag-after-load-firmware.patch
ApplyPatch iwlwifi_-add-function-to-reset_tune-radio-if-needed.patch
ApplyPatch iwlwifi_-Logic-to-control-how-frequent-radio-should-be-reset-if-needed.patch
ApplyPatch iwlwifi_-Tune-radio-to-prevent-unexpected-behavior.patch
ApplyPatch iwlwifi_-multiple-force-reset-mode.patch
ApplyPatch iwlwifi_-fix-scan-race.patch
ApplyPatch iwlwifi_-Adjusting-PLCP-error-threshold-for-1000-NIC.patch
ApplyPatch iwlwifi_-separated-time-check-for-different-type-of-force-reset.patch
ApplyPatch iwlwifi_-add-internal-short-scan-support-for-3945.patch
ApplyPatch iwlwifi_-Recover-TX-flow-stall-due-to-stuck-queue.patch
ApplyPatch iwlwifi_-move-plcp-check-to-separated-function.patch
ApplyPatch iwlwifi_-Recover-TX-flow-failure.patch
ApplyPatch iwlwifi_-code-cleanup-for-connectivity-recovery.patch
ApplyPatch iwlwifi_-iwl_good_ack_health-only-apply-to-AGN-device.patch

set +e +o pipefail
