  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/ImageMagick-add_delegate.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/ImageMagick-6.4.0-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
