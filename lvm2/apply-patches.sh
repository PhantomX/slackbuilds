  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/lvm2-set-default-preferred_names.patch.gz | patch -p1 -E --backup --verbose || exit 1
