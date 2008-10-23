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

zcat ${SB_PATCHDIR}/git-cpufreq.patch.gz | ${PATCHCOM} || exit 1

C=$(zcat ${SB_PATCHDIR}/linux-2.6-hotfixes.patch.gz | wc -l | awk '{print $1}')
if [ "$C" -gt 10 ]; then
  zcat ${SB_PATCHDIR}/linux-2.6-hotfixes.patch.gz | ${PATCHCOM} || exit 1
fi

# Roland's utrace ptrace replacement.
zcat ${SB_PATCHDIR}/linux-2.6-utrace.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-x86-tracehook.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6.27-x86-tracehook-syscall-arg-order.patch.gz | ${PATCHCOM} || exit 1

# enable sysrq-c on all kernels, not only kexec
zcat ${SB_PATCHDIR}/linux-2.6-sysrq-c.patch.gz | ${PATCHCOM} || exit 1

# Architecture patches

# fix oops in get_wchan()
zcat ${SB_PATCHDIR}/linux-2.6-x86-avoid-dereferencing-beyond-stack-THREAD_SIZE.patch.gz | ${PATCHCOM} || exit 1
# fix resume on UP systems with SMP kernel
zcat ${SB_PATCHDIR}/linux-2.6-x86-acpi-fix-resume-on-64-bit-UP-systems.patch.gz | ${PATCHCOM} || exit 1

#
# Exec shield
#
zcat ${SB_PATCHDIR}/linux-2.6-execshield.patch.gz | ${PATCHCOM} || exit 1

#
# bugfixes to drivers and filesystems
#
# Pending ext4 patch queue, minus fiemap, includes s/ext4dev/ext4
zcat ${SB_PATCHDIR}/linux-2.6.27-ext4-stable-patch-queue.patch.gz | ${PATCHCOM} || exit 1
# Disable fiemap until it is really truly upstream & released
zcat ${SB_PATCHDIR}/linux-2.6.27-fs-disable-fiemap.patch.gz | ${PATCHCOM} || exit 1
# CVE-2008-3528, ext-fs dir corruption
zcat ${SB_PATCHDIR}/linux-2.6.27-ext-dir-corruption-fix.patch.gz | ${PATCHCOM} || exit 1

# xfs

# USB
zcat ${SB_PATCHDIR}/linux-2.6-usb-ehci-hcd-respect-nousb.patch.gz | ${PATCHCOM} || exit 1

# Add the ability to turn FIPS-compliant mode on or off at boot
zcat ${SB_PATCHDIR}/linux-2.6-crypto-fips_enable.patch.gz | ${PATCHCOM} || exit 1

# ACPI
zcat ${SB_PATCHDIR}/linux-2.6-defaults-acpi-video.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-video-dos.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-clear-wake-status.patch.gz | ${PATCHCOM} || exit 1

# Various low-impact patches to aid debugging.
zcat ${SB_PATCHDIR}/linux-2.6-debug-sizeof-structs.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-nmi-timeout.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-taint-vm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-spinlock-taint.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-debug-no-quiet.patch.gz | ${PATCHCOM} || exit 1
# try to find out what is breaking acpi-cpufreq
zcat ${SB_PATCHDIR}/linux-2.6-debug-vm-would-have-oomkilled.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-always-inline-kzalloc.patch.gz | ${PATCHCOM} || exit 1

#
# PCI
#
# disable message signaled interrupts
zcat ${SB_PATCHDIR}/linux-2.6-defaults-pci_no_msi.patch.gz | ${PATCHCOM} || exit 1

#
# SCSI Bits.
#
# fix cpqarray pci enable
zcat ${SB_PATCHDIR}/linux-2.6-scsi-cpqarray-set-master.patch.gz | ${PATCHCOM} || exit 1

# ALSA
#

# block/bio
#

# Filesystem patches.
# Squashfs
zcat ${SB_PATCHDIR}/linux-2.6-squashfs.patch.gz | ${PATCHCOM} || exit 1

# Networking
# Disable easy to trigger printk's.
zcat ${SB_PATCHDIR}/linux-2.6-net-silence-noisy-printks.patch.gz | ${PATCHCOM} || exit 1

# Misc fixes
# The input layer spews crap no-one cares about.
zcat ${SB_PATCHDIR}/linux-2.6-input-kill-stupid-messages.patch.gz | ${PATCHCOM} || exit 1

# Allow to use 480600 baud on 16C950 UARTs
zcat ${SB_PATCHDIR}/linux-2.6-serial-460800.patch.gz | ${PATCHCOM} || exit 1
# Silence some useless messages that still get printed with 'quiet'
zcat ${SB_PATCHDIR}/linux-2.6-silence-noise.patch.gz | ${PATCHCOM} || exit 1

# Make fbcon not show the penguins with 'quiet'
zcat ${SB_PATCHDIR}/linux-2.6-silence-fbcon-logo.patch.gz | ${PATCHCOM} || exit 1

# Changes to upstream defaults.
# Use UTF-8 by default on VFAT.
zcat ${SB_PATCHDIR}/linux-2.6-defaults-fat-utf8.patch.gz | ${PATCHCOM} || exit 1

# libata

#
# VM related fixes.
#

# wireless patches headed for 2.6.27
#zcat ${SB_PATCHDIR}/linux-2.6-wireless.patch.gz | ${PATCHCOM} || exit 1
# wireless patches headed for 2.6.28
#zcat ${SB_PATCHDIR}/linux-2.6-wireless-pending.patch.gz | ${PATCHCOM} || exit 1

# fix spot's iwlwifi, hopefully...
zcat ${SB_PATCHDIR}/linux-2.6-iwlwifi-use-dma_alloc_coherent.patch.gz | ${PATCHCOM} || exit 1
# make jarod's iwl4965 not panic near N APs, hopefully
zcat ${SB_PATCHDIR}/linux-2.6-iwlagn-downgrade-BUG_ON-in-interrupt.patch.gz | ${PATCHCOM} || exit 1

# Add misc wireless bits from upstream wireless tree
zcat ${SB_PATCHDIR}/linux-2.6-at76.patch.gz | ${PATCHCOM} || exit 1

# implement smarter atime updates support.
zcat ${SB_PATCHDIR}/linux-2.6-smarter-relatime.patch.gz | ${PATCHCOM} || exit 1

# NFS Client mounts hang when exported directory do not exist
zcat ${SB_PATCHDIR}/linux-2.6-nfs-client-mounts-hang.patch.gz | ${PATCHCOM} || exit 1

# build id related enhancements
zcat ${SB_PATCHDIR}/linux-2.6-default-mmf_dump_elf_headers.patch.gz | ${PATCHCOM} || exit 1

# http://www.lirc.org/
zcat ${SB_PATCHDIR}/linux-2.6-lirc.patch.gz | ${PATCHCOM} || exit 1
# http://hg.jannau.net/hdpvr/
zcat ${SB_PATCHDIR}/linux-2.6-hdpvr.patch.gz | ${PATCHCOM} || exit 1

# Fix the return code CD accesses when the CDROM drive door is closed
# but the drive isn't yet ready.
zcat ${SB_PATCHDIR}/linux-2.6-cdrom-door-status.patch.gz | ${PATCHCOM} || exit 1

# fix sysfs links for the cciss driver
zcat ${SB_PATCHDIR}/linux-2.6-blk-cciss-fix-regression-sysfs-symlink-missing.patch.gz | ${PATCHCOM} || exit 1

# fix RTC on systems with broken PnP
zcat ${SB_PATCHDIR}/linux-2.6-rtc-cmos-look-for-pnp-rtc-first.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-x86-register-platform-rtc-if-pnp-doesnt-describe-it.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-e1000-ich9.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-e1000e-add-support-for-the-82567LM-4-device.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-e1000e-add-support-for-82567LM-3-and-82567LF-3-ICH10D-parts.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-e1000e-add-support-for-new-82574L-part.patch.gz | ${PATCHCOM} || exit 1

# Nouveau DRM + drm fixes
zcat ${SB_PATCHDIR}/nvidia-agp.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-agp-intel-cantiga-fix.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-next.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-modesetting-radeon.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/drm-modesetting-i915.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-nouveau.patch.gz | ${PATCHCOM} || exit 1

# linux1394 git patches
zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-update.patch.gz | ${PATCHCOM} || exit 1
#C=$(zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | wc -l | awk '{print $1}')
#if [ "$C" -gt 10 ]; then
  #zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | ${PATCHCOM} || exit 1
#fi

# get rid of imacfb and make efifb work everywhere it was used
zcat ${SB_PATCHDIR}/linux-2.6-merge-efifb-imacfb.patch.gz | ${PATCHCOM} || exit 1

# silence piix3 in quiet boot (ie, qemu)
zcat ${SB_PATCHDIR}/linux-2.6-piix3-silence-quirk.patch.gz | ${PATCHCOM} || exit 1
# Hush IOMMU warnings, you typically can't fix them anyway
zcat ${SB_PATCHDIR}/linux-2.6-quiet-iommu.patch.gz | ${PATCHCOM} || exit 1
# silence the ACPI blacklist code
zcat ${SB_PATCHDIR}/linux-2.6-silence-acpi-blacklist.patch.gz | ${PATCHCOM} || exit 1
# it's... it's ALIVE!
zcat ${SB_PATCHDIR}/linux-2.6-amd64-yes-i-know-you-live.patch.gz | ${PATCHCOM} || exit 1
# hush pci bar allocation failures
zcat ${SB_PATCHDIR}/linux-2.6.27-pci-hush-allocation-failures.patch.gz | ${PATCHCOM} || exit 1
# EC storms aren't anything you can fix, shut up already
zcat ${SB_PATCHDIR}/linux-2.6.27-acpi-ec-drizzle.patch.gz | ${PATCHCOM} || exit 1
