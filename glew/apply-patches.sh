  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/glew-1.5.1-makefile.patch.gz | patch -p1 -E --backup --verbose || exit 1
