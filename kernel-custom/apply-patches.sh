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

ApplyPatch kbuild-AFTER_LINK.patch

#
# misc small stuff to make things compile
#
ApplyOptionalPatch compile-fixes.patch.gz

# revert patches from upstream that conflict or that we get via other means
ApplyOptionalPatch upstream-reverts.patch -R

ApplyOptionalPatch hotfixes.patch

# vm patches
ApplyPatch mm-Fix-assertion-mapping-nrpages-0-in-end_writeback.patch

# mm patches

# Architecture patches
# x86(-64)
# Add K10 and native cpu optimization support
ApplyPatch add-cpu-optimizations.patch

ApplyPatch x86_64-hpet-64bit-timer.patch

ApplyPatch lib-cpumask-Make-CPUMASK_OFFSTACK-usable-without-deb.patch

#
# Intel IOMMU
#

#
# bugfixes to drivers and filesystems
#

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
ApplyPatch Revert-Revert-ACPI-video-change-acpi-video-brightnes.patch

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

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch input-silence-i8042-noise.patch

# Make fbcon not show the penguins with 'quiet'
ApplyPatch silence-fbcon-logo.patch

# Changes to upstream defaults.

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
ApplyPatch drm-i915-hush-check-crtc-state.patch

# Media (V4L/DVB/IR) updates/fixes/experimental drivers
ApplyOptionalPatch drivers-media-update.patch

# Patches headed upstream
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch lis3-improve-handling-of-null-rate.patch

# Disable watchdog on virtual machines.
ApplyPatch watchdog-Disable-watchdog-on-virtual-machines.patch

#rhbz 754518
ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch

#ApplyPatch weird-root-dentry-name-debug.patch

# https://fedoraproject.org/wiki/Features/Checkpoint_Restore
ApplyPatch criu-no-expert.patch

#rhbz 1110011
ApplyPatch psmouse-Add-psmouse_matches_pnp_id-helper-function.patch
ApplyPatch psmouse-Add-support-for-detecting-FocalTech-PS-2-tou.patch

#rhbz 1123584
ApplyPatch HID-rmi-check-sanity-of-incoming-report.patch

#rhbz 1145318
ApplyPatch KEYS-Reinstate-EPERM-for-a-key-type-name-beginning-w.patch

ApplyPatch GFS2-Make-rename-not-save-dirent-location.patch

#CVE-2014-7970 rhbz 1151095 1151484
ApplyPatch mnt-Prevent-pivot_root-from-creating-a-loop-in-the-m.patch

#rhbz 1149509
ApplyPatch USB-core-add-device-qualifier-quirk.patch
ApplyPatch USB-quirks-enable-device-qualifier-quirk-for-Elan-To.patch
ApplyPatch USB-quirks-enable-device-qualifier-quirk-for-another.patch
ApplyPatch HID-usbhid-add-always-poll-quirk.patch
ApplyPatch HID-usbhid-enable-always-poll-quirk-for-Elan-Touchsc.patch
ApplyPatch HID-usbhid-always-poll-quirk-for-Elan-Touchscreen-00.patch
ApplyPatch USB-quirks-device-qualifier-quirk-for-another-Elan-t.patch
ApplyPatch HID-usbhid-always-poll-quirk-for-Elan-Touchscreen-01.patch

#CVE-2014-7975 rhbz 1151108 1152025
ApplyPatch fs-Add-a-missing-permission-check-to-do_umount.patch

# btrfs fixes queued for 3.17.y
ApplyPatch btrfs-wake-up-transaction-thread-from-SYNC_FS-ioctl.patch
ApplyPatch btrfs-don-t-go-readonly-on-existing-qgroup-items.patch
ApplyPatch btrfs-Fix-a-deadlock-in-btrfs_dev_replace_finishing.patch
ApplyPatch Btrfs-add-missing-compression-property-remove-in-btr.patch
ApplyPatch Btrfs-fix-up-bounds-checking-in-lseek.patch
ApplyPatch btrfs-Fix-and-enhance-merge_extent_mapping-to-insert.patch
ApplyPatch Btrfs-don-t-do-async-reclaim-during-log-replay.patch
ApplyPatch Btrfs-try-not-to-ENOSPC-on-log-replay.patch
ApplyPatch Btrfs-cleanup-error-handling-in-build_backref_tree.patch
ApplyPatch Btrfs-fix-build_backref_tree-issue-with-multiple-sha.patch
ApplyPatch btrfs-Fix-the-wrong-condition-judgment-about-subset-.patch
ApplyPatch Btrfs-fix-race-in-WAIT_SYNC-ioctl.patch
ApplyPatch Revert-Btrfs-race-free-update-of-commit-root-for-ro-.patch

#CVE-2014-8086 rhbz 1151353 1152608
ApplyPatch ext4-fix-race-between-write-and-fcntl-F_SETFL.patch

# By Alon Bar-Lev <alon.barlev <at> gmail.com>
#ApplyPatch ps3-control-ep.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
