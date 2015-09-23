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
ApplyPatch usb-make-xhci-platform-driver-use-64-bit-or-32-bit-D.patch

# WMI

# ACPI

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
# https://groups.google.com/d/msg/bfq-iosched/a5DWtveDzJo/VOvVfnV9AwAJ
ApplyPatch 0001-Fix-check-that-cooperators-belong-to-same-cgroup.patch

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

#rhbz 1253789
ApplyPatch iSCSI-let-session-recovery_tmo-sysfs-writes-persist.patch

#rhbz 1250717
ApplyPatch ext4-dont-manipulate-recovery-flag-when-freezing.patch

#rhbz 1257534
ApplyPatch nv46-Change-mc-subdev-oclass-from-nv44-to-nv4c.patch

#rhbz 1257500
ApplyPatch vmwgfx-Rework-device-initialization.patch
ApplyPatch drm-vmwgfx-Allow-dropped-masters-render-node-like-ac.patch

#rhbz 1259231
ApplyPatch make-flush-workqueue-available-to-non-GPL-modules.patch

#rhbz 1237136
ApplyPatch block-blkg_destroy_all-should-clear-q-root_blkg-and-.patch

#CVE-2015-6937 rhbz 1263139 1263140
ApplyPatch RDS-verify-the-underlying-transport-exists-before-cr.patch

#rhbz 1263762
ApplyPatch 0001-x86-cpu-cacheinfo-Fix-teardown-path.patch

# By Alon Bar-Lev <alon.barlev <at> gmail.com>
#ApplyPatch ps3-control-ep.patch

### Arch
# fix hard lockup in e1000e_cyclecounter_read() after 4 hours of uptime
# https://lkml.org/lkml/2015/8/18/292
ApplyPatch 0001-e1000e-Fix-tight-loop-implementation-of-systime-read.patch

# add not-yet-mainlined patch to fix network unavailability when iptables
# rules are applied during startup - happened with Shorewall; journal had
# many instances of this error: nf_conntrack: table full, dropping packet
ApplyPatch 0001-netfilter-conntrack-use-nf_ct_tmpl_free-in-CT-synpro.patch

# add not-yes-mainlined patch to fix bridge code
# https://bugzilla.kernel.org/show_bug.cgi?id=104161
ApplyPatch 0001-fix-bridge-regression.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
