
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Mandriva/upstreamable patches
zcat ${SB_PATCHDIR}/${NAME}-4.3.50-gstreamer-fix-seekable-query-failed.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.50-phonon-allow-stop-empty-source.patch.gz | patch -p1 -E --backup --verbose
# https://bugs.kde.org/213710
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-subtitles-files-phonon-xine.patch

## Upstream patches

set +e +o pipefail
