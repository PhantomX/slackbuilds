#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
PATCH_DRYRUN=${PATCH_DRYRUN:-NO}

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
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

# Most patches are retrieved from Fedora git repository

ApplyOptionalPatch git-linus.diff

ApplyPatch makefile-after_link.patch

#
# misc small stuff to make things compile
#
ApplyOptionalPatch compile-fixes.patch.gz

# revert patches from upstream that conflict or that we get via other means
ApplyOptionalPatch upstream-reverts.patch -R

ApplyOptionalPatch hotfixes.patch

# vm patches
ApplyPatch oom-warning.patch
ApplyPatch mm-Fix-assertion-mapping-nrpages-0-in-end_writeback.patch

ApplyPatch vmbugon-warnon.patch

#ApplyPatch debug-bad-pte-dmi.patch
ApplyPatch debug-bad-pte-modules.patch

# mm patches

# Architecture patches
# x86(-64)
# Add K10 and native cpu optimization support
ApplyPatch add-cpu-optimizations.patch

ApplyPatch x86_64-hpet-64bit-timer.patch

#
# Intel IOMMU
#

#
# bugfixes to drivers and filesystems
#

ApplyPatch remount-no-shrink-dcache.patch

# reisefs

# ext4

# ext3

# xfs

# btrfs

# cifs

# NFSv4

# USB

# WMI

# ACPI
ApplyPatch defaults-acpi-video.patch
ApplyPatch acpi-sony-nonvs-blacklist.patch

# cpufreq
#ApplyPatch cpufreq_ondemand_performance_optimise_default_settings.patch

#
# PCI
#

#
# SCSI / block Bits.
#

# BFQ disk scheduler - http://algo.ing.unimo.it/people/paolo/disk_sched/
mkdir -p bfq_patches
for file in ${BFQSRCARCHIVES} ;do
  cp ${BFQDOWNDIR}/${file} bfq_patches/
done

( SB_PATCHDIR=bfq_patches
  for file in ${BFQSRCARCHIVES} ;do
    ApplyPatch ${file}
  done
)
ApplyPatch make-bfq-the-default-io-scheduler.patch

# ALSA

# block/bio
#

# Networking

# Misc fixes
# The input layer spews crap no-one cares about.
ApplyPatch input-kill-stupid-messages.patch

# stop floppy.ko from autoloading during udev...
ApplyPatch die-floppy-die.patch

ApplyPatch no-pcspkr-modalias.patch

# Allow to use 480600 baud on 16C950 UARTs
ApplyPatch serial-460800.patch

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch silence-noise.patch

# Make fbcon not show the penguins with 'quiet'
ApplyPatch silence-fbcon-logo.patch.gz

# libata

#
# VM related fixes.
#

# /dev/crash driver.
ApplyPatch crash-driver.patch

# crypto/

# DRM core
#ApplyPatch drm-vgem.patch

# Nouveau DRM

# Intel DRM
ApplyOptionalPatch drm-intel-next.patch
ApplyPatch drm-i915-dp-stfu.patch

# silence the ACPI blacklist code
ApplyPatch silence-acpi-blacklist.patch

# Media (V4L/DVB/IR) updates/fixes/experimental drivers
ApplyOptionalPatch drivers-media-update.patch

# Patches headed upstream
ApplyPatch fs-proc-devtree-remove_proc_entry.patch
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch lis3-improve-handling-of-null-rate.patch

# Disable watchdog on virtual machines.
ApplyPatch nowatchdog-on-virt.patch

#rhbz 754518
ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch

ApplyPatch weird-root-dentry-name-debug.patch

#rhbz 859485
ApplyPatch vt-Drop-K_OFF-for-VC_MUTE.patch

# https://fedoraproject.org/wiki/Features/Checkpoint_Restore
ApplyPatch criu-no-expert.patch

#rhbz 927469
ApplyPatch fix-child-thread-introspection.patch

#CVE-2013-4345 rhbz 1007690 1009136
ApplyPatch ansi_cprng-Fix-off-by-one-error-in-non-block-size-request.patch

#rhbz 985522
ApplyPatch ntp-Make-periodic-RTC-update-more-reliable.patch

#rhbz 902012
ApplyPatch elevator-Fix-a-race-in-elevator-switching-and-md.patch
ApplyPatch elevator-acquire-q-sysfs_lock-in-elevator_change.patch

#rhbz 1015989
ApplyPatch netfilter-nf_conntrack-use-RCU-safe-kfree-for-conntr.patch

#rhbz 982153
ApplyPatch iommu-Remove-stack-trace-from-broken-irq-remapping-warning.patch

#rhbz 998732
ApplyPatch vfio-iommu-Fixed-interaction-of-VFIO_IOMMU_MAP_DMA.patch

#rhbz 993744
ApplyPatch dm-cache-policy-mq_fix-large-scale-table-allocation-bug.patch

#rhbz 1011714
ApplyPatch btrfs-relocate-csums-properly-with-prealloc-ext.patch

#rhbz 1015558
ApplyPatch fix-buslogic.patch

# By Alon Bar-Lev <alon.barlev <at> gmail.com>
ApplyPatch ps3-control-ep.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
