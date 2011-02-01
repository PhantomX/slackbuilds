
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-genkernel.patch
patch -p0 -E --backup -z .chinfo --verbose -i ${SB_PATCHDIR}/grub-1.99-chinfo.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.99-slknew.patch

# From Fedora

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose
for patch in \
  core_in_fs.patch \
  boot_blocklist_hack.patch \
  disable_floppies.patch \
  grub.cfg_400.patch \
  gfxpayload_keep_default.patch \
  mkrescue_diet.patch \
  mkconfig_skip_dmcrypt.patch \
  branch_butter.patch \
  branch_devmapper.patch \
  branch_squash.patch \
  branch_longlinuxcmd.patch \
  branch_parse-color.patch \
  branch_embed-sectors.patch \
  ; do
  patch -p1 -E --backup --verbose -i debian/patches/${patch}
done

set +e +o pipefail
