
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.kde.org/213710
patch -p1 -E --backup -z .subtitles --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.4-subtitles-files-phonon-xine.patch

set +e +o pipefail
