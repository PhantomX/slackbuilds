  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/wesnoth-1.2.8-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
