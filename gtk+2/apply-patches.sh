# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# There's been this long standing debate about PNG and -lz
# and this patch is the workaround.  ;-)
zcat ${SB_PATCHDIR}/gtk.pnglz.diff.gz | patch -p1 -E --backup --verbose || exit 1

# Fix for x86_64 (does not hurt the other archs but note that we will start
# using /etc/gtk-2.0/$host instead of /etc/gtk-2.0/ now):
zcat ${SB_PATCHDIR}/gtk.etc.host.location.diff.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/system-python.patch.gz | patch -p1 --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=583273
zcat ${SB_PATCHDIR}/icon-padding.patch.gz | patch -p1 --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=599617
zcat ${SB_PATCHDIR}/fresh-tooltips.patch.gz | patch -p1 --verbose || exit 1
# from upstream
zcat ${SB_PATCHDIR}/allow-set-hint.patch.gz | patch -p1 --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=599618
zcat ${SB_PATCHDIR}/tooltip-positioning.patch.gz | patch -p1 --verbose || exit 1
# http://bugzilla.redhat.com/show_bug.cgi?id=529364
zcat ${SB_PATCHDIR}/gtk2-remove-connecting-reason.patch.gz | patch -p1 --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=592582
zcat ${SB_PATCHDIR}/gtk2-preview.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/gtk2-rotate-layout.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/gtk2-landscape-pdf-print.patch.gz | patch -p1 --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=600992
zcat ${SB_PATCHDIR}/filesystemref.patch.gz | patch -p1 --verbose || exit 1
