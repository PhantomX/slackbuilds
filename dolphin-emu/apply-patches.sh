
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-indent.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/dolphin-emu-dso.patch
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/dolphin-emu-wiiuse.patch
#sed -i -e 's|"wiiuse.h"|<wiiuse.h>|g' Source/Plugins/Plugin_Wiimote/Src/*.{h,cpp}

set +e +o pipefail
