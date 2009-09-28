
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.gnome.org/show_bug.cgi?id=596136
zcat ${SB_PATCHDIR}/osd-rounded-rectangle.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/osd-visual-refresh.patch.gz | patch -p1 -E --backup --verbose || exit 1
