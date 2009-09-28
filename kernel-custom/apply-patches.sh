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
  local C=$(ApplyPatch ${patch} | wc -l | awk '{print $1}')
  if [ "${C}" -gt 9 ]; then
    ApplyPatch ${patch} ${1+"$@"}
  fi
}

# Adds layer 7 iptables support
#ApplyPatch kernel-2.6.25-layer7-2.20.patch.gz

ApplyPatch acpi-dsdt-initrd-v0.9d-2.6.30-20090730+log.patch.gz

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
ApplyOptionalPatch linux-2.6-upstream-reverts.patch.gz | ${PATCHCOM} -R || exit 1

ApplyOptionalPatch linux-2.6-hotfixes.patch.gz

# Roland's utrace ptrace replacement.
ApplyPatch linux-2.6-tracehook.patch.gz
ApplyPatch linux-2.6-utrace.patch.gz
ApplyPatch linux-2.6-utrace-ftrace.patch.gz

# vm patches
ApplyPatch linux-2.6-defaults-saner-vm-settings.patch.gz
ApplyPatch linux-2.6-mm-lru-evict-streaming-io-pages-first.patch.gz
ApplyPatch linux-2.6-mm-lru-report-vm-flags-in-page-referenced.patch.gz
ApplyPatch linux-2.6-mm-lru-dont-evict-mapped-executable-pages.patch.gz

# enable sysrq-c on all kernels, not only kexec
ApplyPatch linux-2.6-sysrq-c.patch.gz

# Architecture patches
# x86(-64)
ApplyPatch linux-2.6-cpufreq-enable-acpi-pstates-on-via.patch.gz
ApplyPatch via-hwmon-temp-sensor.patch.gz
ApplyPatch via-padlock-10-enable-64bit.patch.gz
ApplyPatch via-padlock-20-add-x86-dependency.patch.gz
ApplyPatch via-padlock-30-fix-might-sleep.patch.gz
ApplyPatch via-padlock-40-nano-ecb.patch.gz
ApplyPatch via-padlock-50-nano-cbc.patch.gz
ApplyPatch via-rng-enable-64bit.patch.gz
ApplyPatch via-sdmmc.patch.gz
ApplyPatch linux-2.6-x86-delay-tsc-barrier.patch.gz

# Export xfrm[4|6] gc_thresh values to sysctl
ApplyPatch linux-2.6-xfrm-export-gc_thresh.patch.gz

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

# cifs
# fix cifs mount option "port=" (#506574)
ApplyPatch linux-2.6-fs-cifs-fix-port-numbers.patch.gz

# USB

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch.gz
ApplyPatch linux-2.6-acpi-video-dos.patch.gz
ApplyPatch linux-2.6.30-cpuidle-faster-io.patch.gz

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

#
# SCSI Bits.
#

# ALSA
# squelch hda_beep by default
ApplyPatch linux-2.6-defaults-alsa-hda-beep-off.patch.gz
ApplyPatch hda_intel-prealloc-4mb-dmabuffer.patch.gz

# block/bio
#

# Filesystem patches.

# Networking
ApplyPatch linux-2.6-missing-rfc2465-stats.patch.gz

# neigh: fix state transition INCOMPLETE->FAILED via Netlink request
ApplyPatch linux-2.6-neigh_-fix-state-transition-INCOMPLETE-_FAILED-via-Netlink-request.patch.gz

# add ich9 lan
ApplyPatch linux-2.6-e1000-ich9.patch.gz

# Virt Fixes
# Xen Guest
ApplyPatch linux-2.6-xen-fix-brkpoints-hw-watchpoints.patch.gz
ApplyPatch linux-2.6-xen-clean-up-warnings.patch.gz

# Misc Virt
ApplyPatch linux-2.6-virtio_blk-revert-QUEUE_FLAG_VIRT-addition.patch.gz

# Misc fixes
# The input layer spews crap no-one cares about.
ApplyPatch linux-2.6-input-kill-stupid-messages.patch.gz

# Get away from having to poll Toshibas
ApplyPatch linux-2.6-input-fix-toshiba-hotkeys.patch.gz

# HID: add support for Bluetooth Wacom pads
ApplyPatch linux-2.6-input-wacom-bluetooth.patch.gz

# Allow to use 480600 baud on 16C950 UARTs
ApplyPatch linux-2.6-serial-460800.patch.gz

# fix oops in nozomi drver (#507005) plus two others
ApplyPatch linux-2.6-drivers-char-low-latency-removal.patch.gz
# let users skip the TXEN bug test
ApplyPatch linux-2.6-serial-add-txen-test-param.patch.gz

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch linux-2.6-silence-noise.patch.gz

# Make fbcon not show the penguins with 'quiet'
ApplyPatch linux-2.6-silence-fbcon-logo.patch.gz

# Changes to upstream defaults.

# back-port scan result aging patches
#ApplyPatch linux-2.6-mac80211-age-scan-results-on-resume.patch.gz

# iwlwifi: fix TX queue race
ApplyPatch linux-2.6-iwlwifi_-fix-TX-queue-race.patch.gz

# zd1211rw: adding 083a:e503 as a ZD1211B device
ApplyPatch linux-2.6-zd1211rw_-adding-083a_e503-as-a-ZD1211B-device.patch.gz

# libata

#
# VM related fixes.
#

# /dev/crash driver.
ApplyPatch linux-2.6-crash-driver.patch.gz

# http://www.lirc.org/
ApplyPatch lirc-2.6.31.patch.gz
ApplyPatch hid-ignore-all-recent-imon-devices.patch.gz
ApplyPatch hdpvr-ir-enable.patch.gz
ApplyPatch lirc-revert-2.6.31-i2c-changes.patch.gz

ApplyPatch agp-set_memory_ucwb.patch.gz
# Nouveau DRM + drm fixes
#ApplyPatch drm-next.patch.gz
ApplyPatch drm-modesetting-radeon.patch.gz
ApplyPatch drm-nouveau.patch.gz
ApplyPatch drm-no-gem-on-i8xx.patch.gz
ApplyPatch drm-i915-resume-force-mode.patch.gz
ApplyPatch drm-intel-big-hammer.patch.gz
ApplyPatch drm-intel-gen3-fb-hack.patch.gz
ApplyPatch drm-intel-hdmi-edid-fix.patch.gz
ApplyPatch drm-intel-gem-use-dma32-on-pae.patch.gz
ApplyPatch drm-modesetting-radeon-fixes.patch.gz
ApplyPatch drm-radeon-new-pciids.patch.gz
ApplyPatch drm-dont-frob-i2c.patch.gz
ApplyPatch drm-radeon-cs-oops-fix.patch.gz
ApplyPatch drm-pnp-add-resource-range-checker.patch.gz
ApplyPatch drm-i915-enable-mchbar.patch.gz

# linux1394 git patches
#ApplyPatch linux-2.6-firewire-git-update.patch.gz
#ApplyOptionalPatch linux-2.6-firewire-git-pending.patch.gz

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch.gz

# kvm
ApplyPatch linux-2.6-kvm-skip-pit-check.patch.gz

# xen
ApplyPatch linux-2.6.29-xen-disable-gbpages.patch.gz

# v12n
ApplyPatch linux-2.6-virtio_blk-dont-bounce-highmem-requests.patch.gz

# V4L/DVB updates/fixes/experimental drivers
#ApplyPatch linux-2.6-v4l-dvb-fixes.patch.gz
#ApplyPatch linux-2.6-v4l-dvb-update.patch.gz
#ApplyPatch linux-2.6-v4l-dvb-experimental.patch.gz
#ApplyPatch linux-2.6-revert-dvb-net-kabi-change.patch.gz
ApplyPatch v4l-dvb-fix-cx25840-firmware-load.patch.gz

# sched fixes cherry-picked from 2.6.32
ApplyPatch sched-deal-with-low-load-in-wake-affine.patch.gz
ApplyPatch sched-disable-NEW-FAIR-SLEEPERS-for-now.patch.gz
ApplyPatch sched-ensure-child-cant-gain-time-over-its-parent-after-fork.patch.gz
ApplyPatch sched-remove-shortcut-from-select-task-rq-fair.patch.gz
# latency defaults from 2.6.32 but changed to be not so aggressive
ApplyPatch sched-retune-scheduler-latency-defaults.patch.gz

ApplyPatch make-mmap_min_addr-suck-less.patch.gz

# ----- send for upstream inclusion -----
ApplyPatch linux-2.6-cifs-reenable-lanman-security.patch.gz

# ----- patches headed for -stable -----

# CVE-2009-2847

# Fix string overflows found by stackprotector:
ApplyPatch hda-check-strcpy-length.patch.gz
ApplyPatch linux-2.6-v4l-dvb-af9015-fix-stack-corruption.patch.gz

# fix stack protector problems with xen on x86_64
ApplyPatch linux-2.6-x86-load-percpu-segment-no-stackprotector.patch.gz
ApplyPatch linux-2.6-xen-rearrange-to-fix-stackprotector.patch.gz

# fix lockdep warnings in cpufreq (#522685)
ApplyPatch linux-2.6-cpufreq-eliminate-lockdep-warnings.patch.gz
ApplyPatch linux-2.6-cpufreq-cleanup-locking-in-ondemand.patch.gz

# fix hostap driver (#522269)
ApplyPatch hostap-revert-toxic-part-of-conversion.patch.gz

# fix cfq performance regression in 2.6.30
ApplyPatch linux-2.6-cfq-choose-new-next-req.patch.gz

# kvm fixes from 2.6.31.1, including fix for CVE-2009-3290
ApplyPatch kvm-guest-fix-bogus-wallclock-physical-address-calculation.patch.gz
ApplyPatch kvm-mmu-make-__kvm_mmu_free_some_pages-handle-empty-list.patch.gz
ApplyPatch kvm-vmx-check-cpl-before-emulating-debug-register-access.patch.gz
ApplyPatch kvm-vmx-fix-cr8-exiting-control-clobbering-by-ept.patch.gz
ApplyPatch kvm-x86-disallow-hypercalls-for-guest-callers-in-rings-0.patch.gz

# appletalk: fix skb leak (CVE-2009-2903)
ApplyPatch appletalk-fix-skb-leak-when-ipddp-interface-is-not-loaded.patch.gz

set +e
