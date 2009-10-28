  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.96-genkernel.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.97-fonts.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.97-chinfo.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose || exit 1
patch -p1 -E --backup --verbose -i debian/patches/01_uuids_and_lvm_dont_play_along_nicely.diff || exit 1
for patch in \
  07_core_in_fs.diff \
  904_disable_floppies.diff \
  907_grub.cfg_400.diff \
  ; do
  patch -p0 -E --backup --verbose -i debian/patches/${patch} || exit 1
done
