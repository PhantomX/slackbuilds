
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-1.7.5-allegropicfix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.7.5-il_endian_h.patch.gz | patch -p1 -E --backup --verbose || exit 1
