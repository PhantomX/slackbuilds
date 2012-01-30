
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.9.15.2-gcc47.patch

set +e +o pipefail
