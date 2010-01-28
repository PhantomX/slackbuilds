  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/vlc-trunk-default_font.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-Default-libv4l2-to-true.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/300_all_pic.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/310_all_mmx_pic.patch.gz | patch -p1 -E --backup --verbose || exit 1
sed -i.dmo_pic -e 's/fno-PIC/fPIC/' libs/loader/Makefile.in
zcat ${SB_PATCHDIR}/320_all_disable_media_list_player_tests.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/vlc-1.0.4-xulrunner-192.patch.gz | patch -p1 -E --backup --verbose || exit 1
if pkg-config --exists libpng14 ;then
  zcat ${SB_PATCHDIR}/vlc-1.0.4-png14.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
