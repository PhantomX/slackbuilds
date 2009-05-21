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

zcat ${SB_PATCHDIR}/acpi-dsdt-initrd-v0.9c-2.6.28.patch.gz | ${PATCHCOM} || exit 1

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

#zcat ${SB_PATCHDIR}/git-cpufreq.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/git-bluetooth.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/git-bluetooth-fixes.patch.gz | ${PATCHCOM} || exit 1

C=$(zcat ${SB_PATCHDIR}/linux-2.6-hotfixes.patch.gz | wc -l | awk '{print $1}')
if [ "$C" -gt 10 ]; then
  zcat ${SB_PATCHDIR}/linux-2.6-hotfixes.patch.gz | ${PATCHCOM} || exit 1
fi

# Roland's utrace ptrace replacement.
zcat ${SB_PATCHDIR}/linux-2.6-tracehook.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-utrace.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-utrace-ftrace.patch.gz | ${PATCHCOM} || exit 1

# vm patches
zcat ${SB_PATCHDIR}/linux-2.6-mm-lru-evict-streaming-io-pages-first.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-mm-lru-dont-evict-mapped-executable-pages.patch.gz | ${PATCHCOM} || exit 1

# Support suspend/resume, other crash fixes
zcat ${SB_PATCHDIR}/linux-2.6-iommu-fixes.patch.gz | ${PATCHCOM} || exit 1

# enable sysrq-c on all kernels, not only kexec
zcat ${SB_PATCHDIR}/linux-2.6-sysrq-c.patch.gz | ${PATCHCOM} || exit 1

# Architecture patches
# Architecture patches
# x86(-64)
#zcat ${SB_PATCHDIR}/linux-2.6-e820-save-restore-edi-ebp.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-e820-acpi3-bios-workaround.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-e820-guard-against-pre-acpi3.patch.gz | ${PATCHCOM} || exit 1

#
# Exec shield
#
zcat ${SB_PATCHDIR}/linux-2.6-execshield.patch.gz | ${PATCHCOM} || exit 1

#
# bugfixes to drivers and filesystems
#

# ext4
zcat ${SB_PATCHDIR}/linux-2.6-ext4-flush-on-close.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-ext4-really-print-warning-once.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-ext4-prealloc-fixes.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-ext4-fake-delalloc-bno.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-ext4-clear-unwritten-flag.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-ext4-fix-i_cached_extent-race.patch.gz | ${PATCHCOM} || exit 1

# xfs

# btrfs
zcat ${SB_PATCHDIR}/linux-2.6-btrfs-experimental-branch.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-btrfs-fix-umount-hang.patch.gz | ${PATCHCOM} || exit 1

# relatime
zcat ${SB_PATCHDIR}/linux-2.6-relatime-by-default.patch.gz | ${PATCHCOM} || exit 1

# put fiemap.h into kernel-headers
zcat ${SB_PATCHDIR}/linux-2.6-fiemap-header-install.patch.gz | ${PATCHCOM} || exit 1

# USB
zcat ${SB_PATCHDIR}/linux-2.6-add-qcserial.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-usb-cdc-acm-remove-low-latency-flag.patch.gz | ${PATCHCOM} || exit 1

# ACPI
zcat ${SB_PATCHDIR}/linux-2.6-defaults-acpi-video.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-video-dos.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-strict-resources.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-hwmon-atk0110.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-video-didl-intel-outputs.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-sony-laptop-rfkill.patch.gz | ${PATCHCOM} || exit 1

# Various low-impact patches to aid debugging.
zcat ${SB_PATCHDIR}/linux-2.6-debug-sizeof-structs.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-nmi-timeout.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-taint-vm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-spinlock-taint.patch.gz | ${PATCHCOM} || exit 1
# try to find out what is breaking acpi-cpufreq
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

# Add /sys/bus/pci/devices/*/remove_id
zcat ${SB_PATCHDIR}/linux-2.6-pci-sysfs-remove-id.patch.gz | ${PATCHCOM} || exit 1

#
# SCSI Bits.
#
# fix cpqarray pci enable
zcat ${SB_PATCHDIR}/linux-2.6-scsi-cpqarray-set-master.patch.gz | ${PATCHCOM} || exit 1

# ALSA
# squelch hda_beep by default
zcat ${SB_PATCHDIR}/linux-2.6-defaults-alsa-hda-beep-off.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6.29-alsa-update-quirks.patch.gz | ${PATCHCOM} || exit 1

# fix alsa for pulseaudio
zcat ${SB_PATCHDIR}/alsa-rewrite-hw_ptr-updaters.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/alsa-pcm-always-reset-invalid-position.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/alsa-pcm-fix-delta-calc-at-overlap.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/alsa-pcm-safer-boundary-checks.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/alsa-hda-dont-reset-BDL-unnecessarily.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/alsa-dont-reset-stream-at-each-prepare-callb.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/alsa-hda_intel-fix-unexpected-ring-buffer-positio.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/alsa-pcm-midlevel-add-more-strict-buffer-position.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/hda_intel-prealloc-4mb-dmabuffer.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/alsa-hda-add-debugging.patch.gz | ${PATCHCOM} || exit 1

# block/bio
#

# Filesystem patches.

# Networking
zcat ${SB_PATCHDIR}/net-revert-forcedeth-power-down-phy-when-interface-is.patch.gz | ${PATCHCOM} || exit 1

# Misc fixes
# The input layer spews crap no-one cares about.
zcat ${SB_PATCHDIR}/linux-2.6-input-kill-stupid-messages.patch.gz | ${PATCHCOM} || exit 1

# Get away from having to poll Toshibas
zcat ${SB_PATCHDIR}/linux-2.6-input-fix-toshiba-hotkeys.patch.gz | ${PATCHCOM} || exit 1

# HID: add support for another version of 0e8f:0003 device in hid-pl
zcat ${SB_PATCHDIR}/linux-2.6-input-hid-extra-gamepad.patch.gz | ${PATCHCOM} || exit 1

# HID: add support for Bluetooth Wacom pads
zcat ${SB_PATCHDIR}/linux-2.6-input-wacom-bluetooth.patch.gz | ${PATCHCOM} || exit 1

# Allow to use 480600 baud on 16C950 UARTs
zcat ${SB_PATCHDIR}/linux-2.6-serial-460800.patch.gz | ${PATCHCOM} || exit 1
# let users skip the TXEN bug test
zcat ${SB_PATCHDIR}/linux-2.6-serial-add-txen-test-param.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/increase-MAX_LOCKDEP_ENTRIES.patch.gz | ${PATCHCOM} || exit 1

# Silence some useless messages that still get printed with 'quiet'
zcat ${SB_PATCHDIR}/linux-2.6-silence-noise.patch.gz | ${PATCHCOM} || exit 1

# Avoid efifb spew
zcat ${SB_PATCHDIR}/linux-2.6-shut-up-efifb.patch.gz | ${PATCHCOM} || exit 1

# Make fbcon not show the penguins with 'quiet'
zcat ${SB_PATCHDIR}/linux-2.6-silence-fbcon-logo.patch.gz | ${PATCHCOM} || exit 1

# Changes to upstream defaults.

# libata

#
# VM related fixes.
#

# rt2x00: back-port activity LED init patches
zcat ${SB_PATCHDIR}/linux-2.6-rt2x00-asus-leds.patch.gz | ${PATCHCOM} || exit 1

# back-port scan result aging patches
zcat ${SB_PATCHDIR}/linux-2.6-mac80211-age-scan-results-on-resume.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-ipw2x00-age-scan-results-on-resume.patch.gz | ${PATCHCOM} || exit 1

# back-port iwlwifi rfkill while device down patches
zcat ${SB_PATCHDIR}/linux-2.6-iwl3945-report-killswitch-changes-even-if-the-interface-is-down.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-iwlagn-fix-hw-rfkill-while-the-interface-is-down.patch.gz | ${PATCHCOM} || exit 1

# back-port mac80211: fix beacon loss detection after scan
zcat ${SB_PATCHDIR}/linux-2.6-mac80211-fix-beacon-loss-detection-after-scan.patch.gz | ${PATCHCOM} || exit 1

# Fix up DMA debug code
zcat ${SB_PATCHDIR}/linux-2.6-dma-debug-fixes.patch.gz | ${PATCHCOM} || exit 1

# /dev/crash driver.
zcat ${SB_PATCHDIR}/linux-2.6-crash-driver.patch.gz | ${PATCHCOM} || exit 1

# http://www.lirc.org/
zcat ${SB_PATCHDIR}/linux-2.6-lirc.patch.gz | ${PATCHCOM} || exit 1

# Fix the return code CD accesses when the CDROM drive door is closed
# but the drive isn't yet ready.
zcat ${SB_PATCHDIR}/linux-2.6-cdrom-door-status.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-e1000-ich9.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/agp-set_memory_ucwb.patch.gz | ${PATCHCOM} || exit 1
# Nouveau DRM + drm fixes
zcat ${SB_PATCHDIR}/drm-next.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-modesetting-radeon.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-nouveau.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-no-gem-on-i8xx.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-i915-resume-force-mode.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-big-hammer.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-lying-systems-without-lvds.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-gen3-fb-hack.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-hdmi-edid-fix.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-tiling-transition.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-next.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-debugfs-ringbuffer.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-edid-ignore-tiny-modes.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-include-965gme-pci-id.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6.29.3-boot-vga.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-gem-use-dma32-on-pae.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-i8xx-cursors.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-vmalloc.patch.gz | ${PATCHCOM} || exit 1

# linux1394 git patches
zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-update.patch.gz | ${PATCHCOM} || exit 1
#C=$(zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | wc -l | awk '{print $1}')
#if [ "$C" -gt 10 ]; then
  #zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | ${PATCHCOM} || exit 1
#fi

# silence the ACPI blacklist code
zcat ${SB_PATCHDIR}/linux-2.6-silence-acpi-blacklist.patch.gz | ${PATCHCOM} || exit 1

# V4L/DVB updates/fixes/experimental drivers
zcat ${SB_PATCHDIR}/linux-2.6-v4l-dvb-fixes.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-v4l-dvb-update.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-v4l-dvb-experimental.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-v4l-dvb-fix-uint16_t-audio-h.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-revert-dvb-net-kabi-change.patch.gz | ${PATCHCOM} || exit 1

# patches headed for -stable
zcat ${SB_PATCHDIR}/squashfs-broken-when-pagesize-greater-than-blocksize.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/hpet-fixes.patch.gz | ${PATCHCOM} || exit 1

# revert 8b249b6856f16f09b0e5b79ce5f4d435e439b9d6
zcat ${SB_PATCHDIR}/revert-fix-modules_install-via-nfs.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/cpufreq-add-atom-to-p4-clockmod.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-dropwatch-protocol.patch.gz | ${PATCHCOM} || exit 1

# kvm fixes
zcat ${SB_PATCHDIR}/linux-2.6-kvm-skip-pit-check.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-xen-check-for-nx-support.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-xen-fix_warning_when_deleting_gendisk.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-xen-xenbus_state_transition_when_not_connected.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6.29-xen-disable-gbpages.patch.gz | ${PATCHCOM} || exit 1
