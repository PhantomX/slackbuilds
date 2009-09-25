
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/concatenate-edid-descriptors.patch.gz | patch -p1 -E --backup --verbose || exit 1
