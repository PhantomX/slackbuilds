
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches
# no overlapping memcpy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.5-no_overlapping_memcpy.patch

set +e +o pipefail
