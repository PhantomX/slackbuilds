
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.44-bid.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.58-syspath.patch

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.48-python64.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.48-undefine-operation.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.50-uninit-var.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.56-gcc46.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.57-cmake_include.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.58-nobuffer_ftoa_utf_link.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.58-python_include.patch

set +e +o pipefail
