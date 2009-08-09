#!/bin/sh

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

# Adds layer 7 iptables support
#zcat ${SB_PATCHDIR}/kernel-2.6.25-layer7-2.20.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/acpi-dsdt-initrd-v0.9d-2.6.30-20090730+log.patch.gz | ${PATCHCOM} || exit 1

# This patch adds a "make nonint_oldconfig" which is non-interactive and
# also gives a list of missing options at the end. Useful for automated
# builds (as used in the buildsystem).
zcat ${SB_PATCHDIR}/linux-2.6-build-nonintconfig.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-makefile-after_link.patch.gz | ${PATCHCOM} || exit 1

#
# misc small stuff to make things compile
#
C=$(zcat ${SB_PATCHDIR}/linux-2.6-compile-fixes.patch.gz | wc -l | awk '{print $1}')
if [ "$C" -gt 10 ]; then
  zcat ${SB_PATCHDIR}/linux-2.6-compile-fixes.patch.gz | ${PATCHCOM} || exit 1
fi

# revert patches from upstream that conflict or that we get via other means
C=$(zcat ${SB_PATCHDIR}/linux-2.6-upstream-reverts.patch.gz | wc -l | awk '{print $1}')
if [ "$C" -gt 10 ]; then
  zcat ${SB_PATCHDIR}/linux-2.6-upstream-reverts.patch.gz | ${PATCHCOM} -R || exit 1
fi

C=$(zcat ${SB_PATCHDIR}/linux-2.6-hotfixes.patch.gz | wc -l | awk '{print $1}')
if [ "$C" -gt 10 ]; then
  zcat ${SB_PATCHDIR}/linux-2.6-hotfixes.patch.gz | ${PATCHCOM} || exit 1
fi

# Roland's utrace ptrace replacement.
zcat ${SB_PATCHDIR}/linux-2.6-tracehook.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-utrace.patch.gz | ${PATCHCOM} || exit 1

# enable sysrq-c on all kernels, not only kexec
zcat ${SB_PATCHDIR}/linux-2.6-sysrq-c.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-missing-rfc2465-stats.patch.gz | ${PATCHCOM} || exit 1

# Architecture patches
# x86(-64)
zcat ${SB_PATCHDIR}/linux-2.6-cpufreq-enable-acpi-pstates-on-via.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/via-hwmon-temp-sensor.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/via-padlock-10-enable-64bit.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/via-padlock-20-add-x86-dependency.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/via-padlock-30-fix-might-sleep.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/via-padlock-40-nano-ecb.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/via-padlock-50-nano-cbc.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/via-rng-enable-64bit.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/via-sdmmc.patch.gz | ${PATCHCOM} || exit 1

# Export xfrm[4|6] gc_thresh values to sysctl
zcat ${SB_PATCHDIR}/linux-2.6-xfrm-export-gc_thresh.patch.gz | ${PATCHCOM} || exit 1

#
# Exec shield
#
zcat ${SB_PATCHDIR}/linux-2.6-execshield.patch.gz | ${PATCHCOM} || exit 1

#
# bugfixes to drivers and filesystems
#

# ext4
#zcat ${SB_PATCHDIR}/linux-2.6-ext4-prealloc-fixes.patch.gz | ${PATCHCOM} || exit 1

# xfs

# btrfs
#zcat ${SB_PATCHDIR}/linux-2.6-btrfs-experimental-branch.patch.gz | ${PATCHCOM} || exit 1

# USB

# ACPI
zcat ${SB_PATCHDIR}/linux-2.6-defaults-acpi-video.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-video-dos.patch.gz | ${PATCHCOM} || exit 1

# Various low-impact patches to aid debugging.
zcat ${SB_PATCHDIR}/linux-2.6-debug-sizeof-structs.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-debug-nmi-timeout.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-debug-taint-vm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-spinlock-taint.patch.gz | ${PATCHCOM} || exit 1
## try to find out what is breaking acpi-cpufreq
zcat ${SB_PATCHDIR}/linux-2.6-debug-vm-would-have-oomkilled.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-always-inline-kzalloc.patch.gz | ${PATCHCOM} || exit 1

#
# PCI
#
# disable message signaled interrupts
zcat ${SB_PATCHDIR}/linux-2.6-defaults-pci_no_msi.patch.gz | ${PATCHCOM} || exit 1

# update the pciehp driver
#zcat ${SB_PATCHDIR}/linux-2.6-pciehp-update.patch.gz | ${PATCHCOM} || exit 1

# default to enabling passively listening for hotplug events
#zcat ${SB_PATCHDIR}/linux-2.6-defaults-pciehp.patch.gz | ${PATCHCOM} || exit 1

#
# SCSI Bits.
#

# ALSA
# squelch hda_beep by default
zcat ${SB_PATCHDIR}/linux-2.6-defaults-alsa-hda-beep-off.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/hda_intel-prealloc-4mb-dmabuffer.patch.gz | ${PATCHCOM} || exit 1

# block/bio
#

# Filesystem patches.

# Networking

# Misc fixes
# The input layer spews crap no-one cares about.
zcat ${SB_PATCHDIR}/linux-2.6-input-kill-stupid-messages.patch.gz | ${PATCHCOM} || exit 1

# Get away from having to poll Toshibas
zcat ${SB_PATCHDIR}/linux-2.6-input-fix-toshiba-hotkeys.patch.gz | ${PATCHCOM} || exit 1

# Allow to use 480600 baud on 16C950 UARTs
zcat ${SB_PATCHDIR}/linux-2.6-serial-460800.patch.gz | ${PATCHCOM} || exit 1

# Silence some useless messages that still get printed with 'quiet'
zcat ${SB_PATCHDIR}/linux-2.6-silence-noise.patch.gz | ${PATCHCOM} || exit 1

# Make fbcon not show the penguins with 'quiet'
zcat ${SB_PATCHDIR}/linux-2.6-silence-fbcon-logo.patch.gz | ${PATCHCOM} || exit 1

# Changes to upstream defaults.

# libata

#
# VM related fixes.
#

# rt2x00: back-port activity LED init patches
#zcat ${SB_PATCHDIR}/linux-2.6-rt2x00-asus-leds.patch.gz | ${PATCHCOM} || exit 1

# back-port scan result aging patches
#zcat ${SB_PATCHDIR}/linux-2.6-mac80211-age-scan-results-on-resume.patch.gz | ${PATCHCOM} || exit 1

# /dev/crash driver.
zcat ${SB_PATCHDIR}/linux-2.6-crash-driver.patch.gz | ${PATCHCOM} || exit 1

# neigh: fix state transition INCOMPLETE->FAILED via Netlink request
zcat ${SB_PATCHDIR}/linux-2.6-neigh_-fix-state-transition-INCOMPLETE-_FAILED-via-Netlink-request.patch.gz | ${PATCHCOM} || exit 1

# http://www.lirc.org/
zcat ${SB_PATCHDIR}/linux-2.6-lirc.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-e1000-ich9.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/agp-set_memory_ucwb.patch.gz | ${PATCHCOM} || exit 1
# Nouveau DRM + drm fixes
#zcat ${SB_PATCHDIR}/drm-next.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/drm-modesetting-radeon.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/drm-nouveau.patch.gz | ${PATCHCOM} || exit 1
# pm broken on my thinkpad t60p - airlied
#zcat ${SB_PATCHDIR}/drm-radeon-pm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-no-gem-on-i8xx.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-i915-resume-force-mode.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-big-hammer.patch.gz | ${PATCHCOM} || exit 1

# linux1394 git patches
#zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-update.patch.gz | ${PATCHCOM} || exit 1
#C=$(zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | wc -l | awk '{print $1}')
#if [ "$C" -gt 10 ]; then
  #zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | ${PATCHCOM} || exit 1
#fi

# silence the ACPI blacklist code
zcat ${SB_PATCHDIR}/linux-2.6-silence-acpi-blacklist.patch.gz | ${PATCHCOM} || exit 1

# V4L/DVB updates/fixes/experimental drivers
#zcat ${SB_PATCHDIR}/linux-2.6-v4l-dvb-fixes.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-v4l-dvb-update.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-v4l-dvb-experimental.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-revert-dvb-net-kabi-change.patch.gz | ${PATCHCOM} || exit 1
