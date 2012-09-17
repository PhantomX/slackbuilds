
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qgit-2.4-qmake.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qgit-2.4-fix-line-skew.patch

set +e +o pipefail
