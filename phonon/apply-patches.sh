
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.4-no_rpath.patch

# https://bugs.kde.org/213710
patch -p1 -E --backup -z .subtitles --verbose -i ${SB_PATCHDIR}/phonon-4.5.0-subtitles-files-phonon-xine.patch

## Upstream patches

set +e +o pipefail
