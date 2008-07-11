  
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/default-theme.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=106249
zcat ${SB_PATCHDIR}/skip-taskbar-tab.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=482354
zcat ${SB_PATCHDIR}/${NAME}-2.21.13-dont-move-windows.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=519188
zcat ${SB_PATCHDIR}/${NAME}-2.22.0-keepabove.patch.gz | patch -p0 -E --backup --verbose || exit 1
# fixed in upstream svn
zcat ${SB_PATCHDIR}/${NAME}-theme-crash.patch.gz | patch -p0 -E --backup --verbose || exit 1
