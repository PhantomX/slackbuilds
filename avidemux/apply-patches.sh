  
SB_PATCHDIR=${CWD}/patches

# Patches from Arch
zcat ${SB_PATCHDIR}/${NAME}-2.5.0-gcc-4.4.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5-i18n.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.0-format-strings.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}_2.5.0-underlinking.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}_2.5.0-wrong-include.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-plugins-2.5.0-gcc-4.4.patch.gz | patch -p1 -E --backup --verbose || exit 1
