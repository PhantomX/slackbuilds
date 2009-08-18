  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libdrm-make-dri-perms-okay.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nouveau-revert-to-abi12.patch.gz | patch -p1 -E --backup --verbose || exit 1
