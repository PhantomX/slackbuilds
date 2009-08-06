
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/fltk-1.1.9-fltk_config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/fltk-1.1.9-test.patch.gz | patch -p1 -E --backup --verbose || exit 1
# libfltk_gl.so had undefined symbols
zcat ${SB_PATCHDIR}/fltk-1.1.x-r5750-undefined.patch.gz | patch -p1 -E --backup --verbose || exit 1
# nuke --rpath (#238284)
zcat ${SB_PATCHDIR}/fltk-1.1.9-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/fltk-1.1.8-fluid_desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/fltk-1.1.9-consts.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/fltk-1.1.9-gcc44.patch.gz | patch -p1 -E --backup --verbose || exit 1
