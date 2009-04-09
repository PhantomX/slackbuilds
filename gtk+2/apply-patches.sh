# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# There's been this long standing debate about PNG and -lz
# and this patch is the workaround.  ;-)
zcat ${SB_PATCHDIR}/gtk.pnglz.diff.gz | patch -p1 -E --backup --verbose || exit 1

# Workaround adobe flash infinite loop.
# Patch from http://bugzilla.gnome.org/show_bug.cgi?id=463773#c11
zcat ${SB_PATCHDIR}/${PNAME}-2.12.0-flash-workaround.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.redhat.com/show_bug.cgi?id=478400
zcat ${SB_PATCHDIR}/default_printer.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=384940
zcat ${SB_PATCHDIR}/print_authentication.patch.gz | patch -p0 -E --backup --verbose || exit 1
