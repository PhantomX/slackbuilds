
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
  linuxefi_amd64_only.patch \
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
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-2.00-slknew.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
