
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Makefile_patch.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Desktop_patch.diff
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-intfgraphics.patch

set +e +o pipefail
