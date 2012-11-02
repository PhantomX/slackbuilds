
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.5.57-plugindir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.6.0-syntax.patch
# https://git.reviewboard.kde.org/r/103423
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.6.0-rpath.patch

## Upstream patches

set +e +o pipefail
