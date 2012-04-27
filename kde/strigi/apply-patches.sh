
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.7-gcc47.patch

## upstream patches
patch -p1 -E --backup --verbose -d libstreamanalyzer -i ${SB_PATCHDIR}/${NAME}-0.7.7-xpmfix.patch

set +e +o pipefail
