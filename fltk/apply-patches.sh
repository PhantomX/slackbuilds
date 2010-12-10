
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/fltk-1.1.9-fltk_config.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/fltk-1.1.9-test.patch.gz | patch -p1 -E --backup --verbose
# libfltk_gl.so had undefined symbols
zcat ${SB_PATCHDIR}/fltk-1.1.x-r5750-undefined.patch.gz | patch -p1 -E --backup --verbose
# nuke --rpath (#238284)
zcat ${SB_PATCHDIR}/fltk-1.1.9-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/fltk-1.1.8-fluid_desktop.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/fltk-1.1.9-gcc44.patch.gz | patch -p1 -E --backup --verbose
# use output of `pkg-config xft --libs` instead of just -lXft
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.1.10-pkgconfig_xft.patch
# only build the fluid binary we intend to install/use (ie, don't build both fluid, fluid-shared)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fltk-1.1.10-fluid_target.patch

set +e +o pipefail
