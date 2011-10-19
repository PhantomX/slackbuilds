
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.5-static_convenience_libs.patch

## upstream patches
patch -p1 -E --backup --verbose -d libstreamanalyzer -i ${SB_PATCHDIR}/${NAME}-0.7.6-libstreamanalyzer_pdf.patch

set +e +o pipefail
