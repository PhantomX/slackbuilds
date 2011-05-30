
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.1.9-fltk_config.patch
# libfltk_gl.so had undefined symbols
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.1.x-r5750-undefined.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.1.8-fluid_desktop.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.1.9-scandir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.3.0-rh708185.patch

set +e +o pipefail
