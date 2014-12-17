
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Adapter-name-now-returns-alias-of-adapter.patch

set +e +o pipefail
