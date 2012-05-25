
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-handle-fwrite-return.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-grub_test_assert_printf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-Workaround-for-variable-set-but-not-used-issue.patch

#filterdiff -p1 -x configure.ac -x ChangeLog -x "po/*" -x "debian/po/*" -z \
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose

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
  btrfs_stat.patch \
  partition_performance.patch \
  gfxterm_background.patch \
  probe_canonicalise.patch \
  mkconfig_skip_readme.patch \
  xfs_invalid_bmap.patch \
  handle_new_autotools.patch \
  bash-completion_identifiers.patch \
  gcc_4_6_space.patch \
  lzo.patch \
  fat_uuid.patch \
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-slknew.patch

set +e +o pipefail
