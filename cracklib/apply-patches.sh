  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/cracklib-2.8.15-suffix.patch.gz | patch -p1 -E --backup --verbose || exit 1
cp -f lib/packer.h lib/packer.h.in || exit 1
zcat ${SB_PATCHDIR}/cracklib-2.8.15-inttypes.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/cracklib-2.8.12-gettext.patch.gz | patch -p1 -E --backup --verbose || exit 1
