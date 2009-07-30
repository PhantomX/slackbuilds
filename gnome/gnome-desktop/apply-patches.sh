
SB_PATCHDIR=${CWD}/patches

zcat ${CWD}/${NAME}-2.27.3-edid-prop-name.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${CWD}/pnpids.patch.gz | patch -p1 -E --backup --verbose || exit 1
