
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fixes from git
# wrong fsf address and missing pkgconfig requires
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/most-of-4c30a84f7899ff63c9bbc39563099f98752c83d6.patch

set +e +o pipefail
