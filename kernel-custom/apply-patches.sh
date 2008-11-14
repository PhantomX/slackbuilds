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

zcat ${SB_PATCHDIR}/linux-2.6-x86-mtrr-kill-bogus-warning.patch.gz | ${PATCHCOM} || exit 1
# check for more ATI timer bugs
zcat ${SB_PATCHDIR}/linux-2.6-x86-sb600-skip-acpi-irq0-override-if-not-routed-to-int2.patch.gz | ${PATCHCOM} || exit 1

# enable sysrq-c on all kernels, not only kexec
zcat ${SB_PATCHDIR}/linux-2.6-sysrq-c.patch.gz | ${PATCHCOM} || exit 1

# Architecture patches

#
# Exec shield
#
zcat ${SB_PATCHDIR}/linux-2.6-execshield.patch.gz | ${PATCHCOM} || exit 1

#
# bugfixes to drivers and filesystems
#
# Pending ext4 patch queue, minus fiemap, includes s/ext4dev/ext4
# ext4/jbd changes up to 2.6.28-rc3-git6
zcat ${SB_PATCHDIR}/linux-2.6.27-ext4-2.6.28-rc3-git6.patch.gz | ${PATCHCOM} || exit 1
# Fixups for the upstream ext4 code to build cleanly in 2.6.27.
zcat ${SB_PATCHDIR}/linux-2.6.27-ext4-2.6.28-backport-fixups.patch.gz | ${PATCHCOM} || exit 1

# xfs

# USB
zcat ${SB_PATCHDIR}/linux-2.6-usb-ehci-hcd-respect-nousb.patch.gz | ${PATCHCOM} || exit 1

# Add the ability to turn FIPS-compliant mode on or off at boot
zcat ${SB_PATCHDIR}/linux-2.6-crypto-fips_enable.patch.gz | ${PATCHCOM} || exit 1

# ACPI
zcat ${SB_PATCHDIR}/linux-2.6-defaults-acpi-video.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-video-dos.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-handle-ec-init-failure.patch.gz | ${PATCHCOM} || exit 1

# Various low-impact patches to aid debugging.
zcat ${SB_PATCHDIR}/linux-2.6-debug-sizeof-structs.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-nmi-timeout.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-taint-vm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-spinlock-taint.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-debug-no-quiet.patch.gz | ${PATCHCOM} || exit 1
# try to find out what is breaking acpi-cpufreq
zcat ${SB_PATCHDIR}/linux-2.6-debug-vm-would-have-oomkilled.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-mm-pagefault-enable-ints.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-always-inline-kzalloc.patch.gz | ${PATCHCOM} || exit 1

#
# PCI
#
# disable message signaled interrupts
zcat ${SB_PATCHDIR}/linux-2.6-defaults-pci_no_msi.patch.gz | ${PATCHCOM} || exit 1

# update the pciehp driver
zcat ${SB_PATCHDIR}/linux-2.6-pciehp-update.patch.gz | ${PATCHCOM} || exit 1

# default to enabling passively listening for hotplug events
zcat ${SB_PATCHDIR}/linux-2.6-defaults-pciehp.patch.gz | ${PATCHCOM} || exit 1

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

# fix overlow with large disk
zcat ${SB_PATCHDIR}/linux-2.6-libata-avoid-overflow-with-large-disks.patch.gz | ${PATCHCOM} || exit 1

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
#zcat ${SB_PATCHDIR}/linux-2.6-iwlwifi-use-dma_alloc_coherent.patch.gz | ${PATCHCOM} || exit 1
# make jarod's iwl4965 not panic near N APs, hopefully
zcat ${SB_PATCHDIR}/linux-2.6-iwlagn-downgrade-BUG_ON-in-interrupt.patch.gz | ${PATCHCOM} || exit 1
# iwl3945 fix for stable ad-hoc mode connections (#459401)
zcat ${SB_PATCHDIR}/linux-2.6-iwl3945-ibss-tsf-fix.patch.gz | ${PATCHCOM} || exit 1
# hostap hack to still work w/ quetionable skb->cb usage
zcat ${SB_PATCHDIR}/linux-2.6-hostap-skb-cb-hack.patch.gz | ${PATCHCOM} || exit 1

# Add misc wireless bits from upstream wireless tree
zcat ${SB_PATCHDIR}/linux-2.6-at76.patch.gz | ${PATCHCOM} || exit 1

# atl2 network driver
zcat ${SB_PATCHDIR}/linux-2.6-netdev-atl2.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-net-tulip-interrupt.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-net-qla-silence-debug-printks.patch.gz | ${PATCHCOM} || exit 1

# implement smarter atime updates support.
zcat ${SB_PATCHDIR}/linux-2.6-smarter-relatime.patch.gz | ${PATCHCOM} || exit 1

# NFS Client mounts hang when exported directory do not exist
zcat ${SB_PATCHDIR}/linux-2.6-nfs-client-mounts-hang.patch.gz | ${PATCHCOM} || exit 1

# implement whitelist for ac97
zcat ${SB_PATCHDIR}/linux-2.6-alsa-ac97-whitelist.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-alsa-ac97-whitelist-AD1981B.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-alsa-revo51-headphone.patch.gz | ${PATCHCOM} || exit 1

# build id related enhancements
zcat ${SB_PATCHDIR}/linux-2.6-default-mmf_dump_elf_headers.patch.gz | ${PATCHCOM} || exit 1

# http://www.lirc.org/
zcat ${SB_PATCHDIR}/linux-2.6-lirc.patch.gz | ${PATCHCOM} || exit 1
# http://hg.jannau.net/hdpvr/
zcat ${SB_PATCHDIR}/linux-2.6-hdpvr.patch.gz | ${PATCHCOM} || exit 1

# Fix the return code CD accesses when the CDROM drive door is closed
# but the drive isn't yet ready.
zcat ${SB_PATCHDIR}/linux-2.6-cdrom-door-status.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-e1000-ich9.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-e1000e-add-support-for-the-82567LM-4-device.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-e1000e-add-support-for-82567LM-3-and-82567LF-3-ICH10D-parts.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-e1000e-add-support-for-new-82574L-part.patch.gz | ${PATCHCOM} || exit 1

#zcat ${SB_PATCHDIR}/linux-2.6-netdev-r8169-2.6.28.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-quieter-mmc.patch.gz | ${PATCHCOM} || exit 1

# Nouveau DRM + drm fixes
zcat ${SB_PATCHDIR}/nvidia-agp.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-next.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-modesetting-radeon.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/drm-modesetting-i915.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-nouveau.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-intel-8xx-pae-no-gem.patch.gz | ${PATCHCOM} || exit 1

# linux1394 git patches
zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-update.patch.gz | ${PATCHCOM} || exit 1
C=$(zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | wc -l | awk '{print $1}')
if [ "$C" -gt 10 ]; then
  zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | ${PATCHCOM} || exit 1
fi

# get rid of imacfb and make efifb work everywhere it was used
zcat ${SB_PATCHDIR}/linux-2.6-merge-efifb-imacfb.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-dmi-autoload.patch.gz | ${PATCHCOM} || exit 1

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
# fix backtrace in pciehp
zcat ${SB_PATCHDIR}/linux-2.6-pci-fix-pciehp.patch.gz | ${PATCHCOM} || exit 1
# don't allocate IRQ 0 in pciehp
zcat ${SB_PATCHDIR}/linux-2.6-pci-fix-pciehp-irq0.patch.gz | ${PATCHCOM} || exit 1
