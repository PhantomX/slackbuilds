
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.44-bid.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.63-syspath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.48-undefine-operation.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.50-uninit-var.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.58-python_include.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.61-openjpeg_stdbool.patch

set +e +o pipefail
