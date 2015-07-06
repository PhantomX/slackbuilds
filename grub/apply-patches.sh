
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

tar xvf ${CWD}/${PSRCARCHIVE}

#cp -f ${SB_PATCHDIR}/linuxefi.patch debian/patches/

### Debian
for patch in \
  core_in_fs.patch \
  disable_floppies.patch \
  grub.cfg_400.patch \
  gfxpayload_keep_default.patch \
  mkrescue_efi_modules.patch \
  mkconfig_loopback.patch \
  restore_mkdevicemap.patch \
  gettext_quiet.patch \
  mkconfig_mid_upgrade.patch \
  install_efi_fallback.patch \
  mkconfig_nonexistent_loopback.patch \
  no_insmod_on_sb.patch \
  default_grub_d.patch \
  blacklist_1440x900x32.patch \
  uefi_firmware_setup.patch \
  linuxefi.patch \
  linuxefi_debug.patch \
  linuxefi_require_shim.patch \
  linuxefi_non_sb_fallback.patch \
  mkconfig_signed_kernel.patch \
  install_signed.patch \
  sleep_shift.patch \
  probe-delimiter.patch \
  tolerate-lvm-snapshots.patch \
  net-receive-packets-yield.patch \
  net-ramp-up-interval.patch \
  probe_nvme.patch \
  mkconfig-kernels-infloop.patch \
  gettext-print-typo.patch \
  grub-install-extra-removable.patch \
  check_blocklists_overlap_fix.patch \
  mixed_size_efi.patch \
  hostfs_remove_ftm.patch \
  efi_sanitise_path.patch \
  arp_icmp_oversize_handling.patch \
  fix_diskfilter_lv_name_dblfree.patch \
  fix_disk-module_option_handling.patch \
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-slknew.patch

### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0021-util-grub-mount.c-Extend-GCC-warning-workaround-to-g.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0027-fix-include-loop-on-MinGW-due-to-libintl.h-pulling-s.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0073-Replace-few-instances-of-memcmp-memcpy-in-the-code-t.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0074-include-grub-libgcc.h-Remove-ctzsi2-and-ctzdi2.-They.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0075-Add-missing-endif.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0142-Files-reorganization-and-include-some-libgcc-fuction.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
