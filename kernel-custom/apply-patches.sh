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

# vm patches
ApplyPatch oom-warning.patch
ApplyPatch mm-Fix-assertion-mapping-nrpages-0-in-end_writeback.patch

ApplyPatch vmbugon-warnon.patch

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
ApplyPatch linux-2.6-defaults-acpi-video.patch
ApplyPatch linux-2.6-acpi-video-dos.patch
ApplyPatch linux-2.6-acpi-debug-infinite-loop.patch
ApplyPatch acpi-sony-nonvs-blacklist.patch
# list acpi fixed events at /proc/acpi/fixed_events
ApplyPatch acpi-add-proc-event-regs.patch

# cpufreq
ApplyPatch cpufreq_ondemand_performance_optimise_default_settings.patch

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

# libata

#
# VM related fixes.
#

# /dev/crash driver.
ApplyPatch linux-2.6-crash-driver.patch

# crypto/

# DRM core
#ApplyPatch drm-vgem.patch

# Nouveau DRM

# Intel DRM
ApplyOptionalPatch drm-intel-next.patch
ApplyPatch drm-i915-dp-stfu.patch

# silence the ACPI blacklist code
ApplyPatch linux-2.6-silence-acpi-blacklist.patch
ApplyPatch quite-apm.patch

# Media (V4L/DVB/IR) updates/fixes/experimental drivers
ApplyOptionalPatch drivers-media-update.patch

# Patches headed upstream
ApplyPatch fs-proc-devtree-remove_proc_entry.patch
ApplyPatch disable-i8042-check-on-apple-mac.patch

# Runtime PM

# rhbz#605888
ApplyPatch dmar-disable-when-ricoh-multifunction.patch

ApplyPatch efi-dont-map-boot-services-on-32bit.patch

ApplyPatch lis3-improve-handling-of-null-rate.patch

#rhbz 754518
ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch

ApplyPatch weird-root-dentry-name-debug.patch

#Build patch, should go away
ApplyPatch irqnr-build.patch

#rhbz 874791
ApplyPatch Bluetooth-Add-support-for-BCM20702A0.patch

#rhbz 859485
ApplyPatch vt-Drop-K_OFF-for-VC_MUTE.patch

#rhbz CVE-2012-4530 868285 880147
ApplyPatch exec-do-not-leave-bprm-interp-on-stack.patch
ApplyPatch exec-use-eloop-for-max-recursion-depth.patch

#rhbz 851278
ApplyPatch 8139cp-re-enable-interrupts-after-tx-timeout.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
