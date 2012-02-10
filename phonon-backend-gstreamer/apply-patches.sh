
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Mandriva/upstreamable patches
#zcat ${SB_PATCHDIR}/phonon-4.3.50-gstreamer-fix-seekable-query-failed.patch.gz | patch -p1 -E --backup --verbose
## Ubuntu/upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.4.3-flac_mimetype.patch

set +e +o pipefail
