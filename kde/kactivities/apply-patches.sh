
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.kde.org/show_bug.cgi?id=305353
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-kde305353.patch

set +e +o pipefail
