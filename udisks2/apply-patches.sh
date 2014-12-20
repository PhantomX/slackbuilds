
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udisks-2.x-ntfs-3g.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
