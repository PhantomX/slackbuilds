
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://git.reviewboard.kde.org/r/103423
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-4.7.0-rpath.patch

## Upstream patches

set +e +o pipefail
