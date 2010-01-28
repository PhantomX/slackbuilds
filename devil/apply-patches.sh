
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-1.7.5-allegropicfix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.7.5-il_endian_h.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_PNG14}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/devil-libpng14.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
