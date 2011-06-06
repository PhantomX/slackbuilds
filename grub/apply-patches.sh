
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-slknew.patch

# From Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-handle-fwrite-return.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-grub_test_assert_printf.patch

filterdiff -p1 -x configure.ac -x ChangeLog -x "po/*" -x "debian/po/*" \
  -z ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose

for patch in \
  core_in_fs.patch \
  disable_floppies.patch \
  grub.cfg_400.patch \
  gfxpayload_keep_default.patch \
  mkrescue_diet.patch \
  mkconfig_skip_dmcrypt.patch \
  branch_devmapper.patch \
  branch_squash.patch \
  branch_longlinuxcmd.patch \
  branch_parse-color.patch \
  branch_embed-sectors.patch \
  branch_fuse.patch \
  mkrescue_efi_modules.patch \
  mkconfig_loopback.patch \
  lazy_stat.patch \
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done

set +e +o pipefail
