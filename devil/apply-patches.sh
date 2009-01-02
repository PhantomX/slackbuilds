  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-1.6.8-rc2-il_endian_h.patch.gz | patch -p1 -E --backup --verbose || exit 1

