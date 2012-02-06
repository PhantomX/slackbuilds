
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-3.15.1-doxygen.patch
patch -p1 -E --backup -z .syslibs --verbose -i ${SB_PATCHDIR}/disable_embedded_libraries.patch
sed -i -e 's|"../ZLib/zlib.h"|<zlib.h>|g' Source/LibTIFF/*.c
sed -i -e 's|"../OpenEXR/Half/half.h"|<half.h>|g' Source/FreeImage/PluginTIFF.cpp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_ftbfs_amd64.patch
patch -p0 -E --backup -z .png15 --verbose -i ${SB_PATCHDIR}/${PNAME}-3.15.1-libpng15.patch

set +e +o pipefail
