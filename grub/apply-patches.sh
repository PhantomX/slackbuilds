
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0042-util-grub-mkconfig_lib.in-grub_tab-New-variable.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0183-grub-core-script-execute.c-gettext_append-Remove-nes.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0237-grub-core-kern-efi-mm.c-grub_efi_finish_boot_service.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0450-Pass-x-hex-hex-straight-through-unmolested.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0455-Add-X-option-to-printf-functions.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0459-add-GRUB_DISABLE_SUBMENU-option.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0461-Move-bash-completion-script-922997.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0464-configure.ac-Don-t-use-extended-registers-on-x86_64.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0465-configure.ac-Don-t-disable-extended-registers-on-emu.patch | patch -p1 -E --backup --verbose
filterdiff -p1 -x ChangeLog -z ${SB_PATCHDIR}/0482-Fix-net_bootp-cmd-crash-when-there-isn-t-network-car.patch | patch -p1 -E --backup --verbose

tar xvf ${CWD}/${PSRCARCHIVE}

cp -f ${SB_PATCHDIR}/mkconfig_nonexistent_loopback.patch debian/patches/

### Debian
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
  uefi_firmware_setup.patch \
  linuxefi.patch \
  linuxefi_amd64_only.patch \
  linuxefi_debug.patch \
  linuxefi_require_shim.patch \
  linuxefi_non_sb_fallback.patch \
  mkconfig_signed_kernel.patch \
  install_signed.patch \
  install_bios_setup_path.patch \
  os_prober_efi.patch \
  acpihalt_improvements.patch \
  script_check_no_commands.patch \
  texinfo_ordering.patch \
  mkconfig_emacs_autosave.patch \
  sleep_shift.patch \
  probe_error_handling.patch \
  maybe_quiet.patch \
  efidisk_non_512_sectors.patch \
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-slknew.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
