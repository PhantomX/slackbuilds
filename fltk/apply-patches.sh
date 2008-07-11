
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.1.x-r5750-199656.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.1.7-test.patch.gz | patch -p1 -E --backup --verbose || exit 1
# libfltk_gl.so had undefined symbols
zcat ${SB_PATCHDIR}/${NAME}-1.1.x-r5750-undefined.patch.gz | patch -p1 -E --backup --verbose || exit 1
# nuke --rpath (#238284)
zcat ${SB_PATCHDIR}/${NAME}-1.1.x-r5750-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.1.8-fluid_desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
