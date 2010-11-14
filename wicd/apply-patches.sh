
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wicd-1.7.0-remove-WHEREAREMYFILES.patch
# https://bugs.launchpad.net/wicd/+bug/602825
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/deepcopy+python27-fixes.patch

set +e +o pipefail
