
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Rotate-documents-correctly.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libspectre-gs918.patch

set +e +o pipefail
