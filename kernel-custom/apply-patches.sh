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
ApplyPatch nx-emu-remove-cpuinitdata-for-disable_nx-on-x86_32.patch

#
# bugfixes to drivers and filesystems
#

ApplyPatch remount-no-shrink-dcache.patch

# reisefs

# ext4
ApplyPatch ext4-Support-check-none-nocheck-mount-options.patch

# ext3

# xfs

# btrfs

# cifs

# NFSv4
#rhbz 717735
ApplyPatch linux-3.1-keys-remove-special-keyring.patch
ApplyPatch linux-3.3-newidmapper-01.patch
ApplyPatch linux-3.3-newidmapper-02.patch
ApplyPatch linux-3.3-newidmapper-03.patch
ApplyPatch NFSv4-Reduce-the-footprint-of-the-idmapper.patch
ApplyPatch NFSv4-Further-reduce-the-footprint-of-the-idmapper.patch
ApplyPatch NFSv4-Minor-cleanups-for-nfs4_handle_exception-and-n.patch

# NFS Client Patch set from Upstream
ApplyPatch NFS-optimise-away-unnecessary-setattrs-for-open-O_TRUNC.patch
ApplyPatch NFSv4-fix-open-O_TRUNC-and-ftruncate-error-handling.patch
ApplyPatch NFSv4-Rate-limit-the-state-manager-for-lock-reclaim-.patch

# USB

# WMI

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch
ApplyPatch linux-2.6-acpi-video-dos.patch
ApplyPatch linux-2.6-acpi-debug-infinite-loop.patch
# list acpi fixed events at /proc/acpi/fixed_events
ApplyPatch acpi-add-proc-event-regs.patch

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
ApplyPatch 0001-block-cgroups-kconfig-build-bits-for-BFQ-v3r3-3.3.patch
ApplyPatch 0002-block-introduce-the-BFQ-v3r3-I-O-sched-for-3.3.patch
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
#ApplyOptionalPatch drm-nouveau-updates.patch

# Intel DRM
ApplyOptionalPatch drm-intel-next.patch
ApplyPatch drm-i915-fbc-stfu.patch

ApplyPatch linux-2.6-intel-iommu-igfx.patch

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch
ApplyPatch quite-apm.patch

# Media (V4L/DVB/IR) updates/fixes/experimental drivers
ApplyPatch add-poll-requested-events.patch
ApplyOptionalPatch drivers-media-update.patch

# Patches headed upstream
ApplyPatch fs-proc-devtree-remove_proc_entry.patch
ApplyPatch disable-i8042-check-on-apple-mac.patch
ApplyPatch linux-3.3-virtio-scsi.patch

# Runtime PM

# rhbz#605888
ApplyPatch dmar-disable-when-ricoh-multifunction.patch

ApplyPatch efi-dont-map-boot-services-on-32bit.patch

ApplyPatch lis3-improve-handling-of-null-rate.patch
ApplyPatch bluetooth-use-after-free.patch
ApplyPatch ips-noirq.patch

#rhbz 772772
ApplyPatch rt2x00_fix_MCU_request_failures.patch

ApplyPatch hfsplus-Change-finder_info-to-u32.patch
ApplyPatch hfsplus-Add-an-ioctl-to-bless-files.patch
ApplyPatch hfsplus-initialise-userflags.patch
ApplyPatch hfsplus-Fix-bless-ioctl-when-used-with-hardlinks.patch

#rhbz 754518
ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch

ApplyPatch mcelog-rcu-splat.patch

#rhbz 804957 CVE-2012-1568
ApplyPatch shlib_base_randomize.patch

ApplyPatch unhandled-irqs-switch-to-polling.patch

ApplyPatch weird-root-dentry-name-debug.patch

#rhbz 804347
ApplyPatch x86-add-io_apic_ops-to-allow-interception.patch
ApplyPatch x86-apic_ops-Replace-apic_ops-with-x86_apic_ops.patch
ApplyPatch xen-x86-Implement-x86_apic_ops.patch

#Highbank clock functions
ApplyPatch highbank-export-clock-functions.patch

#rhbz 807632
ApplyPatch libata-forbid-port-runtime-pm-by-default.patch

#vgaarb patches.  blame mjg59
#ApplyPatch vgaarb-vga_default_device.patch

#rhbz 814278 814289 CVE-2012-2119
ApplyPatch macvtap-zerocopy-validate-vector-length.patch

#rhbz 726143
ApplyPatch 0001-drm-radeon-don-t-mess-with-hot-plug-detect-for-eDP-o.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
