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
ApplyPatch reiserfs-fix-corruption-introduced-by-balance_leaf-refactor.patch
ApplyPatch reiserfs-Fix-use-after-free-in-journal-teardown.patch

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

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch silence-noise.patch

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
ApplyPatch nowatchdog-on-virt.patch

#rhbz 754518
ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch

#ApplyPatch weird-root-dentry-name-debug.patch

# https://fedoraproject.org/wiki/Features/Checkpoint_Restore
ApplyPatch criu-no-expert.patch

#rhbz 1117942
ApplyPatch sched-fix-sched_setparam-policy-1-logic.patch

#CVE-2014-{5206,5207} rhbz 1129662 1129669
ApplyPatch namespaces-remount-fixes.patch

#rhbz 1121288
ApplyPatch 0001-xhci-Blacklist-using-streams-on-the-Etron-EJ168-cont.patch

#rhbz 1128472
ApplyPatch 0001-uas-Limit-qdepth-to-32-when-connected-over-usb-2.patch

#rhbz 1131551
ApplyPatch nfs3_list_one_acl-check-get_acl-result-with-IS_ERR_O.patch

#rhbz 1132666
ApplyPatch xhci-Disable-streams-on-Via-XHCI-with-device-id-0x34.patch

#CVE-2014-{5471,5472} rhbz 1134099 1134101
ApplyPatch isofs-Fix-unbounded-recursion-when-processing-relocated-directories.patch

#rhbz 1132786
ApplyPatch NFSv3-Fix-another-acl-regression.patch

# By Alon Bar-Lev <alon.barlev <at> gmail.com>
#ApplyPatch ps3-control-ep.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
