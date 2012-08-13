
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Ubuntu/upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.4.3-flac_mimetype.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-introduce-bool-to-track-whether-abouttofinish-is-run.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-only-set-skipgapless-and-wake-the-condition-iff-abou.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-only-handle-setNextSource-iff-abouttofinish-is-activ.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-warning.patch

set +e +o pipefail
