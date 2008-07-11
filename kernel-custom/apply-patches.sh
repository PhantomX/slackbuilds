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
zcat ${SB_PATCHDIR}/kernel-2.6.25-layer7-2.18.patch.gz | ${PATCHCOM} || exit 1

# This patch adds a "make nonint_oldconfig" which is non-interactive and
# also gives a list of missing options at the end. Useful for automated
# builds (as used in the buildsystem).
zcat ${SB_PATCHDIR}/linux-2.6-build-nonintconfig.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-upstream-reverts.patch.gz | ${PATCHCOM} -R || exit 1

#zcat ${SB_PATCHDIR}/linux-2.6-hotfixes.patch.gz | ${PATCHCOM} || exit 1

# enable sysrq-c on all kernels, not only kexec
zcat ${SB_PATCHDIR}/linux-2.6-sysrq-c.patch.gz | ${PATCHCOM} || exit 1

# Architecture patches
# x86(-64)
# Delay longer during boot on x86 while waiting for secondary processors
zcat ${SB_PATCHDIR}/linux-2.6-smp-boot-delay.patch.gz | ${PATCHCOM} || exit 1
# don't map or use disabled x86 vdso
zcat ${SB_PATCHDIR}/linux-2.6-x86-dont-map-vdso-when-disabled.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-x86-dont-use-disabled-vdso-for-signals.patch.gz | ${PATCHCOM} || exit 1

#
# bugfixes to drivers and filesystems
#
# USB
zcat ${SB_PATCHDIR}/linux-2.6-usb-ehci-hcd-respect-nousb.patch.gz | ${PATCHCOM} || exit 1

# ACPI
# acpi has a bug in the sizeof function causing thermal panics (from 2.6.26)
zcat ${SB_PATCHDIR}/linux-2.6-acpi-fix-sizeof.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-acpi-fix-error-with-external-methods.patch.gz | ${PATCHCOM} || exit 1

# Various low-impact patches to aid debugging.
zcat ${SB_PATCHDIR}/linux-2.6-debug-sizeof-structs.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-nmi-timeout.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-taint-vm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-debug-spinlock-taint.patch.gz | ${PATCHCOM} || exit 1
#zcat ${SB_PATCHDIR}/linux-2.6-debug-no-quiet.patch.gz | ${PATCHCOM} || exit 1
# try to find out what is breaking acpi-cpufreq
zcat ${SB_PATCHDIR}/linux-2.6-debug-vm-would-have-oomkilled.patch.gz | ${PATCHCOM} || exit 1

#
# Make /dev/mem a need-to-know function
#
zcat ${SB_PATCHDIR}/linux-2.6-devmem.patch.gz | ${PATCHCOM} || exit 1

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
# fix vmware emulated scsi controller
#zcat ${SB_PATCHDIR}/linux-2.6-scsi-mpt-vmware-fix.patch.gz | ${PATCHCOM} || exit 1

# ALSA
#
zcat ${SB_PATCHDIR}/linux-2.6-alsa-kill-annoying-messages.patch.gz | ${PATCHCOM} || exit 1

# Filesystem patches.
# fix rsync inability to write to vfat partitions
zcat ${SB_PATCHDIR}/linux-2.6-fs-fat-cleanup-code.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-fs-fat-fix-setattr.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-fs-fat-relax-permission-check-of-fat_setattr.patch.gz | ${PATCHCOM} || exit 1

# Networking
# Disable easy to trigger printk's.
zcat ${SB_PATCHDIR}/linux-2.6-net-silence-noisy-printks.patch.gz | ${PATCHCOM} || exit 1
# CVE-2008-2750: l2tp heap overflow
zcat ${SB_PATCHDIR}/linux-2.6-net-l2tp-fix-potential-memory-corruption-in-pppol2tp_recvmsg.patch.gz | ${PATCHCOM} || exit 1

# Misc fixes
# The input layer spews crap no-one cares about.
zcat ${SB_PATCHDIR}/linux-2.6-input-kill-stupid-messages.patch.gz | ${PATCHCOM} || exit 1

# Allow to use 480600 baud on 16C950 UARTs
zcat ${SB_PATCHDIR}/linux-2.6-serial-460800.patch.gz | ${PATCHCOM} || exit 1
# Silence some useless messages that still get printed with 'quiet'
zcat ${SB_PATCHDIR}/linux-2.6-silence-noise.patch.gz | ${PATCHCOM} || exit 1

# libata
# fix hangs on undock (#439197)
zcat ${SB_PATCHDIR}/linux-2.6-libata-acpi-hotplug-fixups.patch.gz | ${PATCHCOM} || exit 1
# fix problems with some old/broken CF hardware (F8 #224005)
zcat ${SB_PATCHDIR}/linux-2.6-libata-be-a-bit-more-slack-about-early-devices.patch.gz | ${PATCHCOM} || exit 1
# Make Eee disk faster.
zcat ${SB_PATCHDIR}/linux-2.6-sata-eeepc-faster.patch.gz | ${PATCHCOM} || exit 1
# fix dock/undock on docking stations that have a bay
zcat ${SB_PATCHDIR}/linux-2.6-libata-acpi-handle-bay-devices-in-dock-stations.patch.gz | ${PATCHCOM} || exit 1
# fix DMA disable on atiixp
zcat ${SB_PATCHDIR}/linux-2.6-libata-pata_atiixp-dont-disable.patch.gz | ${PATCHCOM} || exit 1
# retry enabling AHCI mode before reporting error
zcat ${SB_PATCHDIR}/linux-2.6-libata-retry-enabling-ahci.patch.gz | ${PATCHCOM} || exit 1

#
# VM related fixes.
#

# wireless patches headed for 2.6.26
zcat ${SB_PATCHDIR}/linux-2.6-wireless.patch.gz | ${PATCHCOM} || exit 1
# wireless patches headed for 2.6.27
zcat ${SB_PATCHDIR}/linux-2.6-wireless-pending.patch.gz | ${PATCHCOM} || exit 1

# Add misc wireless bits from upstream wireless tree
zcat ${SB_PATCHDIR}/linux-2.6-at76.patch.gz | ${PATCHCOM} || exit 1

# fixups to make current wireless patches build on this kernel
zcat ${SB_PATCHDIR}/linux-2.6-wireless-fixups.patch.gz | ${PATCHCOM} || exit 1

# implement smarter atime updates support.
zcat ${SB_PATCHDIR}/linux-2.6-smarter-relatime.patch.gz | ${PATCHCOM} || exit 1

# NFS Client mounts hang when exported directory do not exist
zcat ${SB_PATCHDIR}/linux-2.6-nfs-client-mounts-hang.patch.gz | ${PATCHCOM} || exit 1

# build id related enhancements
zcat ${SB_PATCHDIR}/linux-2.6-default-mmf_dump_elf_headers.patch.gz | ${PATCHCOM} || exit 1

# http://www.lirc.org/
zcat ${SB_PATCHDIR}/linux-2.6-lirc.patch.gz | ${PATCHCOM} || exit 1

# virtio: dont hang on shutdown
zcat ${SB_PATCHDIR}/linux-2.6-virtio_net-free-transmit-skbs-in-a-timer.patch.gz | ${PATCHCOM} || exit 1

zcat ${SB_PATCHDIR}/linux-2.6-e1000-ich9.patch.gz | ${PATCHCOM} || exit 1

# atl2 driver for eeepc (and others)
zcat ${SB_PATCHDIR}/linux-2.6-netdev-atl2.patch.gz | ${PATCHCOM} || exit 1

# Nouveau DRM + drm fixes
zcat ${SB_PATCHDIR}/linux-2.6-drm-git-mm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/nouveau-drm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/nouveau-drm-update.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-drm-i915-modeset.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-drm-radeon-fix-oops.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-drm-radeon-fix-oops2.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-drm-modesetting-oops-fixes.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/linux-2.6-drm-fix-master-perm.patch.gz | ${PATCHCOM} || exit 1
zcat ${SB_PATCHDIR}/drm-radeon-update.patch.gz | ${PATCHCOM} || exit 1

# linux1394 git patches
zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-update.patch.gz | ${PATCHCOM} || exit 1
C=$(zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | wc -l | awk '{print $1}')
if [ "$C" -gt 10 ]; then
  zcat ${SB_PATCHDIR}/linux-2.6-firewire-git-pending.patch.gz | ${PATCHCOM} || exit 1
fi

# usb video
zcat ${SB_PATCHDIR}/linux-2.6-uvcvideo.patch.gz | ${PATCHCOM} || exit 1

# get rid of imacfb and make efifb work everywhere it was used
zcat ${SB_PATCHDIR}/linux-2.6-merge-efifb-imacfb.patch.gz | ${PATCHCOM} || exit 1
