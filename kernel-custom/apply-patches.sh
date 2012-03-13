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

#
# bugfixes to drivers and filesystems
#

ApplyPatch remount-no-shrink-dcache.patch

# reisefs

# ext4
#rhbz 753346
ApplyPatch jbd-jbd2-validate-sb-s_first-in-journal_get_superblo.patch
ApplyPatch ext4-Support-check-none-nocheck-mount-options.patch
ApplyPatch ext4-Fix-error-handling-on-inode-bitmap-corruption.patch
#rhbz 788269
ApplyPatch jbd2-clear-BH_Delay-and-BH_Unwritten-in-journal_unmap_buf.patch

# ext3

# xfs

# btrfs

# cifs

# NFSv4
ApplyPatch linux-3.1-keys-remove-special-keyring.patch
#rhbz 717735
ApplyPatch nfs-client-freezer.patch

# USB

# WMI

# ACPI
ApplyPatch linux-2.6-defaults-acpi-video.patch.gz
ApplyPatch linux-2.6-acpi-video-dos.patch
ApplyPatch linux-2.6-acpi-debug-infinite-loop.patch
ApplyPatch acpi-ensure-thermal-limits-match-cpu-freq.patch
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
ApplyPatch 0001-block-prepare-I-O-context-code-for-BFQ-v3r2-for-3.2.patch
ApplyPatch 0002-block-cgroups-kconfig-build-bits-for-BFQ-v3r2-3.2.patch
ApplyPatch 0003-block-introduce-the-BFQ-v3r2-I-O-sched-for-3.2.patch
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

# V4L/DVB updates/fixes/experimental drivers
ApplyOptionalPatch linux-2.6-v4l-dvb-fixes.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-update.patch
ApplyOptionalPatch linux-2.6-v4l-dvb-experimental.patch

# Patches headed upstream
ApplyPatch disable-i8042-check-on-apple-mac.patch

# Runtime PM

# rhbz#605888
ApplyPatch dmar-disable-when-ricoh-multifunction.patch

ApplyPatch revert-efi-rtclock.patch
ApplyPatch efi-dont-map-boot-services-on-32bit.patch

ApplyPatch hibernate-freeze-filesystems.patch
ApplyPatch lis3-improve-handling-of-null-rate.patch

#rhbz 752176
ApplyPatch sysfs-msi-irq-per-device.patch

#rhbz 590880
ApplyPatch alps.patch

#rhbz 771058
ApplyPatch msi-irq-sysfs-warning.patch

#rhbz 773392
ApplyPatch KVM-x86-extend-struct-x86_emulate_ops-with-get_cpuid.patch
ApplyPatch KVM-x86-fix-missing-checks-in-syscall-emulation.patch

#rhbz 782686
ApplyPatch procfs-parse-mount-options.patch
ApplyPatch procfs-add-hidepid-and-gid-mount-options.patch
ApplyPatch proc-fix-null-pointer-deref-in-proc_pid_permission.patch

#rhbz 785806
ApplyPatch e1000e-Avoid-wrong-check-on-TX-hang.patch

#rhbz 754518
#ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch
ApplyPatch scsi-fix-sd_revalidate_disk-oops.patch

#rhbz 727865 730007
ApplyPatch ACPICA-Fix-regression-in-FADT-revision-checks.patch

#Disable threading in hibernate compression
ApplyPatch disable-threading-in-compression-for-hibernate.patch

ApplyPatch unhandled-irqs-switch-to-polling.patch

ApplyPatch weird-root-dentry-name-debug.patch

ApplyPatch x86-ioapic-add-register-checks-for-bogus-io-apic-entries.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
