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
ApplyPatch acpi-video-dos.patch
ApplyPatch acpi-debug-infinite-loop.patch
ApplyPatch acpi-sony-nonvs-blacklist.patch
# list acpi fixed events at /proc/acpi/fixed_events
ApplyPatch acpi-add-proc-event-regs.patch

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
ApplyPatch 0001-block-bfq-attempt-to-fix-use-after-free-which-3.3.0-to-3.8.0.patch
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

# no-one cares about these warnings.
ApplyPatch silence-empty-ipi-mask-warning.patch

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
ApplyPatch quiet-apm.patch

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

#rhbz 859485
ApplyPatch vt-Drop-K_OFF-for-VC_MUTE.patch

#rhbz 799564
ApplyPatch Input-increase-struct-ps2dev-cmdbuf-to-8-bytes.patch
ApplyPatch Input-add-support-for-Cypress-PS2-Trackpads.patch

#rhbz 903192
ApplyPatch 0001-kmsg-Honor-dmesg_restrict-sysctl-on-dev-kmsg.patch

#rhbz 916544
ApplyPatch 0001-drivers-crypto-nx-fix-init-race-alignmasks-and-GCM-b.patch

ApplyPatch userns-avoid-recursion-in-put_user_ns.patch

# https://fedoraproject.org/wiki/Features/Checkpoint_Restore
ApplyPatch criu-no-expert.patch

#rhbz 920586
ApplyPatch amd64_edac_fix_rank_count.patch

#rhbz 921500
ApplyPatch i7300_edac_single_mode_fixup.patch

#rhbz 879462
ApplyPatch uvcvideo-suspend-fix.patch

#rhbz 859282
ApplyPatch VMX-x86-handle-host-TSC-calibration-failure.patch

#rhbz 927469
ApplyPatch fix-child-thread-introspection.patch

#CVE-2013-3222 rhbz 955216 955228
ApplyPatch atm-update-msg_namelen-in-vcc_recvmsg.patch

#CVE-2013-3224 rhbz 955599 955607
ApplyPatch Bluetooth-fix-possible-info-leak-in-bt_sock_recvmsg.patch

#CVE-2013-1979 rhbz 955629 955647
ApplyPatch net-fix-incorrect-credentials-passing.patch

#CVE-2013-3225 rhbz 955649 955658
ApplyPatch Bluetooth-RFCOMM-Fix-missing-msg_namelen-update-in-r.patch

#CVE-2013-3223 rhbz 955662 955666
ApplyPatch ax25-fix-info-leak-via-msg_name-in-ax25_recvmsg.patch

#CVE-2013-3234 956135 956139
ApplyPatch rose-fix-info-leak-via-msg_name-in-rose_recvmsg.patch

#CVE-2013-3233 956125 956129
ApplyPatch NFC-llcp-fix-info-leaks-via-msg_name-in-llcp_sock_re.patch

#CVE-2013-3232 956110 956113
ApplyPatch netrom-fix-invalid-use-of-sizeof-in-nr_recvmsg.patch

#CVE-2013-3231 956094 956104
ApplyPatch llc-Fix-missing-msg_namelen-update-in-llc_ui_recvmsg.patch

#CVE-2013-3230 956088 956089
ApplyPatch l2tp-fix-info-leak-in-l2tp_ip6_recvmsg.patch

#CVE-2013-3228 956069 956071
ApplyPatch irda-Fix-missing-msg_namelen-update-in-irda_recvmsg_.patch

# https://bugzilla.novell.com/show_bug.cgi?id=806966
ApplyPatch e1000e-fix-accessing-to-suspended-device.patch
ApplyPatch e1000e-fix-runtime-power-management-transitions.patch

# By Alon Bar-Lev <alon.barlev <at> gmail.com>
ApplyPatch ps3-control-ep.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
