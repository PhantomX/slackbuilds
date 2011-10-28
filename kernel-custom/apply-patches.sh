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

ApplyPatch perf-check-ownership.patch

ApplyOptionalPatch linux-2.6-hotfixes.patch

# utrace
ApplyPatch utrace.patch

# vm patches
ApplyPatch grab-swap-token-oops.patch

# mm patches
ApplyPatch mm-Fix-assertion-mapping-nrpages-0-in-end_writeback.patch

# Minor fixes from 3.0-3.1-rc4 not included in -stable
ApplyPatch mm-swap-token-makes-global-variables-to-function-local.patch
ApplyPatch mm-thp-minor-lock-simplification-in-__khugepaged_exit.patch
ApplyPatch mm-remove-ZAP_BLOCK_SIZE.patch
ApplyPatch mm-vmscan-fix-force-scanning-small-targets-without-swap.patch
ApplyPatch mm-vmscan-drop-nr_force_scan-from-get_scan_count.patch
ApplyPatch mm-vmscan-clear-ZONE_CONGESTED-for-zone-with-good-watermark.patch

# Architecture patches
# x86(-64)
# Add K10 and native cpu optimization support
ApplyPatch linux-3.0-add-cpu-optimizations.patch

ApplyPatch reorganize_stop_cpus.patch
ApplyPatch implement-stop_machine_from_inactive_cpu.patch
ApplyPatch use_stop_machine_for_mtrr_rendezvous.patch

ApplyPatch x86_64-hpet-64bit-timer.patch

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
ApplyPatch reiserfs-barrier-default.patch
ApplyPatch reiserfs-force-inode-evictions-before-umount-to-avoid-crash.patch

# ext4

# ext3
ApplyPatch ext3-barrier-default.patch

# xfs
ApplyPatch xfs-Fix-possible-memory-corruption-in-xfs_readlink.patch

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
ApplyPatch acpi-ensure-thermal-limits-match-cpu-freq.patch
# list acpi fixed events at /proc/acpi/fixed_events
ApplyPatch acpi-add-proc-event-regs.patch

# Various low-impact patches to aid debugging.
ApplyPatch linux-2.6-debug-taint-vm.patch
## try to find out what is breaking acpi-cpufreq
ApplyPatch linux-2.6-debug-vm-would-have-oomkilled.patch

# cpufreq
ApplyPatch cpufreq_ondemand_performance_optimise_default_settings.patch
## cpuidle perf events cleanups and related
ApplyPatch perf_timechart_fix_zero_timestamps.patch

#
# PCI
#
# enable ASPM by default on hardware we expect to work
ApplyPatch linux-2.6-defaults-aspm.patch.gz

#
# SCSI / block Bits.
#
ApplyPatch scsi-check-host-lookup-failure.patch

# BFQ disk scheduler - http://algo.ing.unimo.it/people/paolo/disk_sched/
ApplyPatch 0001-block-prepare-I-O-context-code-for-BFQ-v3-for-3.0.patch
ApplyPatch 0002-block-cgroups-kconfig-build-bits-for-BFQ-v3-3.0.patch
ApplyPatch 0003-block-introduce-the-BFQ-v3-I-O-sched-for-3.0.patch
ApplyPatch make-bfq-the-default-io-scheduler.patch

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

ApplyPatch linux-2.6.30-no-pcspkr-modalias.patch

# Allow to use 480600 baud on 16C950 UARTs
ApplyPatch linux-2.6-serial-460800.patch

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch linux-2.6-silence-noise.patch

# Make fbcon not show the penguins with 'quiet'
ApplyPatch linux-2.6-silence-fbcon-logo.patch.gz

# Get rid of useless bridge window conflict warnings
ApplyPatch x86-pci-reduce-severity-of-host-bridge-window-conflict-warnings.patch

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

# Nouveau DRM
ApplyOptionalPatch drm-nouveau-updates.patch

# Intel DRM
ApplyOptionalPatch drm-intel-next.patch
ApplyPatch drm-intel-make-lvds-work.patch
ApplyPatch drm-i915-sdvo-lvds-is-digital.patch
ApplyPatch linux-2.6-intel-iommu-igfx.patch

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch

# V4L/DVB updates/fixes/experimental drivers
ApplyOptionalPatch linux-2.6-v4l-dvb-fixes.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-update.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-experimental.patch

# Avoid false quiescent states in rcu.
ApplyPatch rcutree-avoid-false-quiescent-states.patch

# Patches headed upstream
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch udlfb-bind-framebuffer-to-interface.patch
ApplyPatch ums-realtek-driver-uses-stack-memory-for-DMA.patch
ApplyPatch rcu-avoid-just-onlined-cpu-resched.patch
ApplyPatch block-stray-block-put-after-teardown.patch
ApplyPatch usb-add-quirk-for-logitech-webcams.patch
ApplyPatch crypto-register-cryptd-first.patch
ApplyPatch x86-efi-Calling-__pa-with-an-ioremap-address-is-invalid.patch

# Runtime PM
#ApplyPatch linux-2.6-usb-pci-autosuspend.patch
#ApplyPatch linux-2.6-enable-more-pci-autosuspend.patch

# rhbz#605888
ApplyPatch dmar-disable-when-ricoh-multifunction.patch

ApplyPatch epoll-fix-spurious-lockdep-warnings.patch
ApplyPatch epoll-limit-paths.patch

ApplyPatch efi-dont-map-boot-services-on-32bit.patch

ApplyPatch iwlagn-check-for-priv--txq-in-iwlagn_wait_tx_queue_empty.patch

# rhbz#719607
ApplyPatch vfs-fix-automount-for-negative-autofs-dentries.patch

#rhbz 740645
ApplyPatch md-dont-delay-reboot-by-1-second-if-no-MD-devices.patch

# rhbz #496675
ApplyPatch Platform-fix-samsung-laptop-DMI-identification-for-N.patch

# rhbz #700718
ApplyPatch x86-Save-stack-pointer-in-perf-live-regs-savings.patch
ApplyPatch x86-Fetch-stack-from-regs-when-possible-in-dump_trac.patch

#rhbz #708563
ApplyPatch binfmt_elf-fix-PIE-execution-with-random-disabled.patch

#rhbz #722509
ApplyPatch mmc-Always-check-for-lower-base-frequency-quirk-for-.patch

#rhbz #735946
ApplyPatch 0001-mm-vmscan-Limit-direct-reclaim-for-higher-order-allo.patch
ApplyPatch 0002-mm-Abort-reclaim-compaction-if-compaction-can-procee.patch

#rhbz 748691
ApplyPatch be2net-move-to-new-vlan-model.patch
ApplyPatch be2net-non-member-vlan-pkts-not-received-in-promisco.patch
ApplyPatch benet-remove-bogus-unlikely-on-vlan-check.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
