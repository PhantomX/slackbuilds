
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.gcc43.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.gcc47.diff

set +e +o pipefail
