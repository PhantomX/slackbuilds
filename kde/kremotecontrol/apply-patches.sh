
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# lib namelink_skip
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.90-namelink_skip.patch

set +e +o pipefail
