
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/antlr-2.7.7-newgcc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/2.7.7-static-libs-fix.patch

set +e +o pipefail
