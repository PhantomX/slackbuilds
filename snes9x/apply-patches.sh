  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.43-wmclass.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-config.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-opengl.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.51-x11.patch.gz | patch -p1 -E --backup --verbose || exit 1
