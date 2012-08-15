
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Ubuntu/upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.4.3-flac_mimetype.patch

set +e +o pipefail
