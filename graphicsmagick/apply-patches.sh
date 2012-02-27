
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.3.14-perl_linkage.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.13-lzma_configure.patch

set +e +o pipefail
