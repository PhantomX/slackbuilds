
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugs.kde.org/305333
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/phonon-backend-4.6.2-xvimagesink_sync.patch

set +e +o pipefail
