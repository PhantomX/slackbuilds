  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/logview-close-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/logview-scroll-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=497489
zcat ${SB_PATCHDIR}/logview-versions-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=497490
zcat ${SB_PATCHDIR}/logview-versions-format.patch.gz | patch -p1 -E --backup --verbose || exit 1
