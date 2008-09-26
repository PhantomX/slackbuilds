  
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/default-theme.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=482354
zcat ${SB_PATCHDIR}/${NAME}-2.21.13-dont-move-windows.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=552303
zcat ${SB_PATCHDIR}/leaks.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=552307
zcat ${SB_PATCHDIR}/string-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1
