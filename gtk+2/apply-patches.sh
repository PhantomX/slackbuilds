# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# There's been this long standing debate about PNG and -lz
# and this patch is the workaround.  ;-)
zcat ${SB_PATCHDIR}/gtk.pnglz.diff.gz | patch -p1 -E --backup --verbose

# Fix for x86_64 (does not hurt the other archs but note that we will start
# using /etc/gtk-2.0/$host instead of /etc/gtk-2.0/ now):
zcat ${SB_PATCHDIR}/gtk.etc.host.location.diff.gz | patch -p1 --verbose

zcat ${SB_PATCHDIR}/system-python.patch.gz | patch -p1 --verbose
# https://bugzilla.gnome.org/show_bug.cgi?id=583273
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/icon-padding.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=599617
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/fresh-tooltips.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=599618
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/tooltip-positioning.patch
# http://bugzilla.redhat.com/show_bug.cgi?id=529364
zcat ${SB_PATCHDIR}/gtk2-remove-connecting-reason.patch.gz | patch -p1 --verbose
# https://bugzilla.gnome.org/show_bug.cgi?id=592582
#zcat ${SB_PATCHDIR}/gtk2-landscape-pdf-print.patch.gz | patch -p1 --verbose
# https://bugzilla.gnome.org/show_bug.cgi?id=611313
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/window-dragging.patch

# Remove the definition of libpixbufloader_gdip_png_la_*
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/gtk+-2.20.1-libpixbufloader-warning.patch
# Redraw if GtkRange is a GtkScale and value is drawn.
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/gtk+-2.20.1-gtkrange.patch
# Fix upstream "table cells do not implement action interface"
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/gtk+-2.20.1-gail_cell_type.patch
# Upstream bg 608218: GtkOffscreenWindow causes bad window with GtkEntry
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/gtk+-2.20.1-GtkOffscreenWindow.patch

# Revert 64bit fix issue
patch -p1 -R --backup --verbose -i ${SB_PATCHDIR}/gtk-png-ulong.patch

set +e +o pipefail
