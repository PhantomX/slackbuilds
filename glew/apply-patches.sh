  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/glew-1.5.2-makefile.patch.gz | patch -p1 -E --backup --verbose || exit 1
