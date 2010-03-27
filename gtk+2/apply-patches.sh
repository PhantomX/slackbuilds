# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

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

set +e +o pipefail
