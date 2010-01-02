  
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/show_bug.cgi?id=593030
zcat ${SB_PATCHDIR}/gtk-engines-2.18.2-change-bullet.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/tooltips.patch.gz | patch -p1 -E --backup --verbose || exit 1
