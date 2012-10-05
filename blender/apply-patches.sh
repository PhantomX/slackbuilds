
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.64-syspath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.58-python_include.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.64-openjpeg_stdbool.patch

set +e +o pipefail
