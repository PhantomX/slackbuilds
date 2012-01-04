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

# utrace
ApplyPatch utrace.patch

# vm patches
ApplyPatch oom-warning.patch
ApplyPatch grab-swap-token-oops.patch
ApplyPatch mm-Fix-assertion-mapping-nrpages-0-in-end_writeback.patch
ApplyPatch oom-thaw-threads-if-oom-killed-thread-is-frozen-befo.patch

# mm patches

# Architecture patches
# x86(-64)
# Add K10 and native cpu optimization support
ApplyPatch linux-3.0-add-cpu-optimizations.patch

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
ApplyPatch reiserfs-force-inode-evictions-before-umount-to-avoid-crash.patch

# ext4
ApplyPatch jbd-jbd2-validate-sb-s_first-in-journal_get_superblo.patch

# ext3

# xfs

# btrfs

# cifs

# NFSv4
ApplyPatch nfsv4-include-bitmap-in-nfsv4_get_acl_data.patch

# USB

# WMI

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch.gz
ApplyPatch linux-2.6-acpi-video-dos.patch
ApplyPatch linux-2.6-acpi-debug-infinite-loop.patch
ApplyPatch acpi-ensure-thermal-limits-match-cpu-freq.patch
# list acpi fixed events at /proc/acpi/fixed_events
ApplyPatch acpi-add-proc-event-regs.patch

# Various low-impact patches to aid debugging.
ApplyPatch linux-2.6-debug-taint-vm.patch

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
ApplyPatch 0001-block-prepare-I-O-context-code-for-BFQ-v3r1-for-3.1.patch
ApplyPatch 0002-block-cgroups-kconfig-build-bits-for-BFQ-v3r1-3.1.patch
ApplyPatch 0003-block-introduce-the-BFQ-v3r1-I-O-sched-for-3.1.patch
ApplyPatch make-bfq-the-default-io-scheduler.patch

# ALSA

# block/bio
#

# Networking

# Misc fixes
# The input layer spews crap no-one cares about.
ApplyPatch linux-2.6-input-kill-stupid-messages.patch

# stop floppy.ko from autoloading during udev...
ApplyPatch die-floppy-die.patch
ApplyPatch floppy-drop-disable_hlt-warning.patch

ApplyPatch linux-2.6.30-no-pcspkr-modalias.patch

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

# Nouveau DRM
ApplyOptionalPatch drm-nouveau-updates.patch

# Intel DRM
ApplyOptionalPatch drm-intel-next.patch
ApplyPatch drm-i915-fbc-stfu.patch
ApplyPatch drm-i915-sdvo-lvds-is-digital.patch

ApplyPatch drm-lower-severity-radeon-lockup.diff

ApplyPatch linux-2.6-intel-iommu-igfx.patch

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch
ApplyPatch quite-apm.patch

# V4L/DVB updates/fixes/experimental drivers
ApplyOptionalPatch linux-2.6-v4l-dvb-fixes.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-update.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-experimental.patch

# Avoid false quiescent states in rcu.
ApplyPatch rcutree-avoid-false-quiescent-states.patch

# Patches headed upstream
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch udlfb-bind-framebuffer-to-interface.patch
ApplyPatch epoll-limit-paths.patch
ApplyPatch rcu-avoid-just-onlined-cpu-resched.patch
ApplyPatch block-stray-block-put-after-teardown.patch

# Runtime PM

# rhbz#605888
ApplyPatch dmar-disable-when-ricoh-multifunction.patch

ApplyPatch revert-efi-rtclock.patch
ApplyPatch efi-dont-map-boot-services-on-32bit.patch

ApplyPatch hvcs_pi_buf_alloc.patch

#rhbz #735946
ApplyPatch 0001-mm-vmscan-Limit-direct-reclaim-for-higher-order-allo.patch
ApplyPatch 0002-mm-Abort-reclaim-compaction-if-compaction-can-procee.patch
ApplyPatch mm-do-not-stall-in-synchronous-compaction-for-THP-allocations.patch

#rhbz 748691
ApplyPatch be2net-non-member-vlan-pkts-not-received-in-promisco.patch
ApplyPatch benet-remove-bogus-unlikely-on-vlan-check.patch

#rhbz 736815
ApplyPatch x86-code-dump-fix-truncation.patch

#rhbz 750402
ApplyPatch oom-fix-integer-overflow-of-points.patch

#rhbz 728607
ApplyPatch elantech.patch

#rhbz 748210
ApplyPatch ideapad-Check-if-acpi-already-handle-backlight.patch

#rhbz 752176
ApplyPatch sysfs-msi-irq-per-device.patch

ApplyPatch pci-Rework-ASPM-disable-code.patch

#rhbz #757839
ApplyPatch net-sky2-88e8059-fix-link-speed.patch

#rhbz 717735
ApplyPatch nfs-client-freezer.patch

#rhbz 746097
ApplyPatch tpm_tis-delay-after-aborting-cmd.patch

ApplyPatch thp-reduce-khugepaged-freezing-latency.patch

ApplyPatch route-cache-garbage-collector.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
