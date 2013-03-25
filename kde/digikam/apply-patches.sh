
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.1.0-htmlexport.patch

## upstream patches

set +e +o pipefail
