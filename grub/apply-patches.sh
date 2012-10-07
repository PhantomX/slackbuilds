
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-ignore-gnulib-gets-stupidity.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-Handle-escapes-in-labels.patch

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
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-slknew.patch

set +e +o pipefail
