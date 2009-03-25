
SB_PATCHDIR=${CWD}/patches

# Patches from Mandriva
zcat ${SB_PATCHDIR}/${NAME}-0.7.3-imgconvert-header.patch.gz | patch -p1 -E --backup --verbose || exit 1
