# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# There's been this long standing debate about PNG and -lz
# and this patch is the workaround.  ;-)
#zcat ${SB_PATCHDIR}/gtk.pnglz.diff.gz | patch -p1 -E --backup --verbose

patch -p1 --backup --verbose -i ${SB_PATCHDIR}/gtk-lib64-slk.patch

zcat ${SB_PATCHDIR}/system-python.patch.gz | patch -p1 --verbose
# https://bugzilla.gnome.org/show_bug.cgi?id=583273
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/icon-padding.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=599618
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/tooltip-positioning.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=592582
#zcat ${SB_PATCHDIR}/gtk2-landscape-pdf-print.patch.gz | patch -p1 --verbose
# https://bugzilla.gnome.org/show_bug.cgi?id=611313
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/window-dragging.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/gtk2-fixdso.patch

# From Debian
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/003_gdk.pc_privates.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/015_default-fallback-icon-theme.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/042_treeview_single-focus.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/060_ignore-random-icons.patch

set +e +o pipefail
