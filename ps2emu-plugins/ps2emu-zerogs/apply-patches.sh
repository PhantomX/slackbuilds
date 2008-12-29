  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-gcc43.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-devbuild-paths.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-consistent-naming.patch.gz | patch -p0 -E --backup --verbose || exit 1
( cd opengl || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-custom-cflags.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
zcat ${SB_PATCHDIR}/${NAME}-compile-shaders.patch.gz | patch -p0 -E --backup --verbose || exit 1
