# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Don't cache the resolving of /dev/mapper/... symlinks, they may point
# to a different /dev/dm-# by the time we use the cached result.
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/parted-dev-mapper-symlink-rh577824.patch
# Add a partition flag for detecting diagnostics / recovery partitions
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/parted-2.2-add-diag-flag-rh583626.patch
# Properly check dm_task_run return codes
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/parted-2.2-dm_task_run-retcode-rh585158.patch
# Fix mkpartfs (ext2) on partition >2TB
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/parted-2.2-blkoflow-rh585159.patch

set +e +o pipefail
