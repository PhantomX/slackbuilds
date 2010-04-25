
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Patch to remove port locking and apply the system-wide /usr/sbin directory
# to the path instead of the default /usr/local
zcat ${SB_PATCHDIR}/${NAME}-config.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
