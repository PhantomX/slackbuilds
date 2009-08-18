  
SB_PATCHDIR=${CWD}/patches

# Patches from Arch
zcat ${SB_PATCHDIR}/${NAME}-2.5-i18n.patch.gz | patch -p1 -E --backup --verbose || exit 1
