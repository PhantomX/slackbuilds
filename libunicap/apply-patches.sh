
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.12-includes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.12-memerrs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.12-arraycmp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.12-warnings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-bz641623.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-bz642118.patch

set +e +o pipefail
