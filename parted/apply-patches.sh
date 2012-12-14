
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.0-libparted-copy-pmbr_boot-when-duplicating-GPT-disk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-check-PMBR-before-GPT-partition-table-8052.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-tests-add-t0301-overwrite-gpt-pmbr.sh.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-Fix-endian-error-with-FirstUsableLBA.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-2.1-libparted-use-dm_udev_wait-698121.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-use-largest_partnum-in-dm_reread_part_tabl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-test-creating-20-device-mapper-partitions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-preserve-the-uuid-on-dm-partitions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-tests-Make-sure-dm-UUIDs-are-not-erased.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-reallocate-buf-after-_disk_analyse_block_s.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-tests-cleanup-losetup-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-add-support-for-implicit-FBA-DASD-partitions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-add-support-for-EAV-DASD-partitions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-don-t-canonicalize-dev-md-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-libparted-mklabel-eav.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/parted-3.1-avoid-dasd-as-default-file-image-type.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
