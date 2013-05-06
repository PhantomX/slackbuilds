
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-Handle-escapes-in-labels.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-add-X-option-to-printf-functions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-add-GRUB-DISABLE-SUBMENU-option.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-fix-docs.patch

tar xvf ${CWD}/${PSRCARCHIVE}

for patch in \
  core_in_fs.patch \
  disable_floppies.patch \
  grub.cfg_400.patch \
  gfxpayload_keep_default.patch \
  mkrescue_diet.patch \
  mkconfig_skip_dmcrypt.patch \
  mkrescue_efi_modules.patch \
  mkconfig_loopback.patch \
  restore_mkdevicemap.patch \
  efi_mmap_size.patch \
  gettext_quiet.patch \
  mkconfig_mid_upgrade.patch \
  fix_powerpc_emu.patch \
  install_efi_fallback.patch \
  mkconfig_overescaping.patch \
  efifwsetup.patch \
  msdos_embed_off_by_one.patch \
  mkconfig_stderr_handling.patch \
  tftp_endianness.patch \
  mkconfig_nonexistent_loopback.patch \
  mount_readdir_symlink_failures.patch \
  initrd_addr_min.patch \
  gnulib_gets.patch \
  no_insmod_on_sb.patch \
  default_grub_d.patch \
  blacklist_1440x900x32.patch \
  kfreebsd_9.1.patch \
  linuxefi.patch \
  linuxefi_amd64_only.patch \
  linuxefi_debug.patch \
  linuxefi_require_shim.patch \
  linuxefi_non_sb_fallback.patch \
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-slknew.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
