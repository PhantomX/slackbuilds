
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.96-genkernel.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup -z .chinfo --verbose -i ${SB_PATCHDIR}/grub-1.98-chinfo.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.98-slknew.patch

# From Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.97.1-initramfs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/grub-1.98-follow-dev-mapper-symlinks.patch

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose
patch -p1 -E --backup --verbose -i debian/patches/01_uuids_and_lvm_dont_play_along_nicely.diff
for patch in \
  07_core_in_fs.diff \
  904_disable_floppies.diff \
  907_grub.cfg_400.diff \
  ; do
  patch -p0 -E --backup --verbose -i debian/patches/${patch}
done
patch -p1 -E --backup --verbose -i debian/patches/908_gfxpayload_keep_default.diff

set +e +o pipefail
