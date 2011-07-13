
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Put video parameters after audio.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-command-order.patch
# git patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-defs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-git-update-01.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-git-update-02.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-git-update-03.patch

set +e +o pipefail
