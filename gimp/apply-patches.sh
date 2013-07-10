
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Exit properly while loading an image (#633107).
# Upstream commit 2dd51be1ce18b11a207efc90e3e8e8c07ba6f7d7 and commit
# bc44719702a5cdcc4944a9a5e1f310c1740c6308
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.8.6-exit-while-loading.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
