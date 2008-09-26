
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.1.90-kdetheme.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=549960
zcat ${SB_PATCHDIR}/rr-leaks.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/clone-modes.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=552856
zcat ${SB_PATCHDIR}/${NAME}-2.23.92-fade.patch.gz | patch -p1 -E --backup --verbose || exit 1
