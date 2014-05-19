
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.2-suppress-warning.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.2-API-adds.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.2-matrix_declarations.patch

set +e +o pipefail
