  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/gimp-2.6.0-xdg-open.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=559081
# "JPEG Save dialog preview should adjust size units"
zcat ${SB_PATCHDIR}/gimp-2.6.2-jpeg-units.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=556896
# "Dialogs don't get minimized with single image window"
zcat ${SB_PATCHDIR}/gimp-2.6.6-minimize-dialogs.patch.gz | patch -p1 -E --backup --verbose || exit 1

if pkg-config --exists libpng14 ;then
  zcat ${SB_PATCHDIR}/gimp-2.6.8-libpng14.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
