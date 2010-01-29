
SB_PATCHDIR=${CWD}/patches

# Patches from Mandriva
zcat ${SB_PATCHDIR}/${NAME}-0.7.3-imgconvert-header.patch.gz | patch -p1 -E --backup --verbose || exit 1
if pkg-config --exists libpng14 ;then
  zcat ${SB_PATCHDIR}/nucleo-0.7.6-png14.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
