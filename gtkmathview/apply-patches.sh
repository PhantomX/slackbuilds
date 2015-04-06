
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/${NAME}-0.8.0-gcc43.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.8.0-includes.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-marshalling-functions-git7d938a.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc-fixes-git3918e8.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-ComputerModernShaper-git210206.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-lowercasegreek-gitb03152.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.0-gcc47.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.0-t1lib-private.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
