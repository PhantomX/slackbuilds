
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libgdither-0.6-default.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libgdither-0.6-gavl.patch

set +e +o pipefail
