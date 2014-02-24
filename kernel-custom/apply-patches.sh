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
ApplyPatch mm-Fix-assertion-mapping-nrpages-0-in-end_writeback.patch

# mm patches

# Architecture patches
# x86(-64)
# Add K10 and native cpu optimization support
ApplyPatch add-cpu-optimizations.patch

ApplyPatch x86_64-hpet-64bit-timer.patch

ApplyPatch 0001-lib-cpumask-Make-CPUMASK_OFFSTACK-usable-without-deb.patch

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
ApplyPatch defaults-acpi-video.patch

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
ApplyPatch silence-fbcon-logo.patch

# Changes to upstream defaults.

#rhbz 917708
ApplyPatch Revert-userns-Allow-unprivileged-users-to-create-use.patch

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
ApplyPatch fs-proc-devtree-remove_proc_entry.patch
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch lis3-improve-handling-of-null-rate.patch

# Disable watchdog on virtual machines.
ApplyPatch nowatchdog-on-virt.patch

#rhbz 754518
ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch

#ApplyPatch weird-root-dentry-name-debug.patch

# https://fedoraproject.org/wiki/Features/Checkpoint_Restore
ApplyPatch criu-no-expert.patch

#rhbz 993744
ApplyPatch dm-cache-policy-mq_fix-large-scale-table-allocation-bug.patch

# Fix 15sec NFS mount delay
ApplyPatch sunrpc-create-a-new-dummy-pipe-for-gssd-to-hold-open.patch
ApplyPatch sunrpc-replace-gssd_running-with-more-reliable-check.patch
ApplyPatch nfs-check-gssd-running-before-krb5i-auth.patch
#rhbz 1037793
ApplyPatch rpc_pipe-remove-the-clntXX-dir-if-creating-the-pipe-fails.patch
ApplyPatch sunrpc-add-an-info-file-for-the-dummy-gssd-pipe.patch
ApplyPatch rpc_pipe-fix-cleanup-of-dummy-gssd-directory-when-notification-fails.patch

#rhbz 924916
ApplyPatch KVM-MMU-handle-invalid-root_hpa-at-__direct_map.patch

#rhbz 1047892
ApplyPatch KVM-VMX-fix-use-after-free-of-vmx-loaded_vmcs.patch

#rhbz 950630
ApplyPatch xhci-fix-resume-issues-on-renesas-chips-in-samsung-laptops.patch

#rhbz 1045755
ApplyPatch cgroup-fixes.patch

#rhbz 1064430 1056711
ApplyPatch ipv6-introduce-IFA_F_NOPREFIXROUTE-and-IFA_F_MANAGETEMPADDR-flags.patch
ApplyPatch ipv6-addrconf-revert-if_inet6ifa_flag-format.patch

#CVE-2014-0069 rhbz 1064253 1062584
ApplyPatch cifs-ensure-that-uncached-writes-handle-unmapped-areas-correctly.patch
ApplyPatch cifs-sanity-check-length-of-data-to-send-before-sending.patch

#rhbz 1054408
ApplyPatch cpufreq-powernow-k8-Initialize-per-cpu-data-structures-properly.patch

#rhbz 994438
ApplyPatch e100-Fix-disabling-already-disabled-device-warning.patch

# By Alon Bar-Lev <alon.barlev <at> gmail.com>
#ApplyPatch ps3-control-ep.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
