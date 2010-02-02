# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/parted-2.1-blkid_topology_get_physical_sector_size.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/parted-2.1-mem-leak-fixes-rh556012.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/parted-2.1-default-alignment.patch.gz | patch -p1 -E --backup --verbose || exit 1
