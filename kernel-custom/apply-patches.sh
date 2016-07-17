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

ApplyPatch kbuild-AFTER_LINK.patch

#
# misc small stuff to make things compile
#
ApplyOptionalPatch compile-fixes.patch.gz

# revert patches from upstream that conflict or that we get via other means
ApplyOptionalPatch upstream-reverts.patch -R

ApplyOptionalPatch hotfixes.patch

# vm patches
### openSUSE patches.suse
# Patches to export btrfs anonymous devices (VFS portion)
ApplyPatch vfs-add-super_operations-get_inode_dev.patch
  
# mm patches

# Architecture patches
# x86(-64)
# Add K10 and native cpu optimization support
ApplyPatch add-cpu-optimizations.patch

### openSUSE patches.arch
#ApplyPatch x86_64-hpet-64bit-timer.patch

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
### openSUSE patches.suse
ApplyPatch btrfs-advertise-which-crc32c-implementation-is-being-used-on-mount.patch
ApplyPatch btrfs-provide-super_operations-get_inode_dev.patch

# cifs

# NFSv4

# USB

# WMI

# ACPI

# cpufreq
### openSUSE patches.arch
ApplyPatch perf_timechart_fix_zero_timestamps.patch

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

# Nouveau DRM

# Intel DRM
ApplyPatch drm-i915-hush-check-crtc-state.patch

# Patches headed upstream
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch lis3-improve-handling-of-null-rate.patch

# Disable watchdog on virtual machines.
ApplyPatch watchdog-Disable-watchdog-on-virtual-machines.patch

#rhbz 754518
ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch

# https://fedoraproject.org/wiki/Features/Checkpoint_Restore
ApplyPatch criu-no-expert.patch

#CVE-2015-2150 rhbz 1196266 1200397
ApplyPatch xen-pciback-Don-t-disable-PCI_COMMAND-on-PCI-device-.patch

#rhbz 1212230
ApplyPatch Input-synaptics-pin-3-touches-when-the-firmware-repo.patch

#rhbz 1133378
ApplyPatch firmware-Drop-WARN-from-usermodehelper_read_trylock-.patch

#rhbz 1226743
ApplyPatch drm-i915-turn-off-wc-mmaps.patch

#Required for some persistent memory options
ApplyPatch disable-CONFIG_EXPERT-for-ZONE_DMA.patch

#CVE-2016-4482 rhbz 1332931 1332932
ApplyPatch USB-usbfs-fix-potential-infoleak-in-devio.patch

#CVE-2016-4569 rhbz 1334643 1334645
ApplyPatch ALSA-timer-Fix-leak-in-SNDRV_TIMER_IOCTL_PARAMS.patch
ApplyPatch ALSA-timer-Fix-leak-in-events-via-snd_timer_user_cca.patch
ApplyPatch ALSA-timer-Fix-leak-in-events-via-snd_timer_user_tin.patch

#CVE-2016-4440 rhbz 1337806 1337807
ApplyPatch kvm-vmx-more-complete-state-update-on-APICv-on-off.patch

#CVE-2016-5243 rhbz 1343338 1343335
ApplyPatch tipc-fix-an-infoleak-in-tipc_nl_compat_link_dump.patch

#CVE-2016-5244 rhbz 1343338 1343337
ApplyPatch rds-fix-an-infoleak-in-rds_inc_info_copy.txt

#CVE-2016-5829 rhbz 1350509 1350513
ApplyPatch HID-hiddev-validate-num_values-for-HIDIOCGUSAGES-HID.patch

#CVE-2016-1237 rhbz 1350845 1350847
ApplyPatch posix_acl-Add-set_posix_acl.patch
ApplyPatch nfsd-check-permissions-when-setting-ACLs.patch

#CVE-2016-5389 CVE-2016-5969 rhbz 1354708 1355615
ApplyPatch tcp-make-challenge-acks-less-predictable.patch

# https://lists.fedoraproject.org/archives/list/kernel@lists.fedoraproject.org/message/A4YCP7OGMX6JLFT5V44H57GOMAQLC3M4/
ApplyPatch drm-amdgpu-Disable-RPM-helpers-while-reprobing.patch
ApplyPatch drm-i915-skl-Add-support-for-the-SAGV-fix-underrun-hangs.patch
ApplyPatch Revert-ALSA-hda-remove-controller-dependency-on-i915.patch

# By Alon Bar-Lev <alon.barlev <at> gmail.com>
#ApplyPatch ps3-control-ep.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
