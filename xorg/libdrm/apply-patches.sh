  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libdrm-make-dri-perms-okay.patch.gz | patch -p1 -E --backup --verbose || exit 1
