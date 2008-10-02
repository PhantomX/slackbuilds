# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# There's been this long standing debate about PNG and -lz
# and this patch is the workaround.  ;-)
zcat ${SB_PATCHDIR}/gtk.pnglz.diff.gz | patch -p1 -E --backup --verbose || exit 1

# Fedora patch
zcat ${SB_PATCHDIR}/${PNAME}-2.11.1-set-invisible-char-to-bullet.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Workaround adobe flash infinite loop.
# Patch from http://bugzilla.gnome.org/show_bug.cgi?id=463773#c11
zcat ${SB_PATCHDIR}/${PNAME}-2.12.0-flash-workaround.patch.gz | patch -p1 -E --backup --verbose || exit 1
# OpenOffice.org might hang at startup (on non-gnome env) without this workaround, bug #193513
zcat ${SB_PATCHDIR}/${PNAME}-2.12.0-openoffice-freeze-workaround.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Various fixes from upstream gtk-2-14 branch, will be part of 2.14.4
zcat ${SB_PATCHDIR}/${PNAME}-2.14.3-fix-filesystem-double-free.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.14.3-fix-lpr_write-double-free.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.14.3-fix-password-dialog-on-mount.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.14.3-notebook-tab-draw-correctness.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.14.3-dont-unset-filechooser-filter-after-first-use.patch.gz | patch -p2 -E --backup --verbose || exit 1

# Don't break inclusion of gtkclist.h, upstream bug 536767
zcat ${SB_PATCHDIR}/${PNAME}-2.14.3-limit-gtksignal-includes.patch.gz | patch -p0 -E --backup --verbose || exit 1

# broken compose keys (see fixed bug #554506 and bug #554192)
zcat ${SB_PATCHDIR}/${PNAME}-2.14.3-fix-combining-broken-diacritics.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.14.3-reorder-compose-key-table-order.patch.gz | patch -p0 -E --backup --verbose || exit 1
