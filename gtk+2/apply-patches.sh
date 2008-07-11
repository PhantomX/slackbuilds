# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# There's been this long standing debate about PNG and -lz
# and this patch is the workaround.  ;-)
zcat ${SB_PATCHDIR}/gtk.pnglz.diff.gz | patch -p1 -E --backup --verbose || exit 1

# Fedora patch
zcat ${SB_PATCHDIR}/${PNAME}-2.11.1-set-invisible-char-to-bullet.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=488119
zcat ${SB_PATCHDIR}/system-log-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1

# backport from svn trunk
zcat ${SB_PATCHDIR}/im-setting.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Backported patch from recent upstream
zcat ${SB_PATCHDIR}/printer-state.patch.gz | patch -p0 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=204621
zcat ${SB_PATCHDIR}/printer-paper-size.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Workaround adobe flash infinite loop.
# Patch from http://bugzilla.gnome.org/show_bug.cgi?id=463773#c11
zcat ${SB_PATCHDIR}/${PNAME}-2.12.0-flash-workaround.patch.gz | patch -p1 -E --backup --verbose || exit 1
# OpenOffice.org might hang at startup (on non-gnome env) without this workaround, bug #193513
zcat ${SB_PATCHDIR}/${PNAME}-2.12.0-openoffice-freeze-workaround.patch.gz | patch -p0 -E --backup --verbose || exit 1
# Firefox print review crash fix, bug #195644
zcat ${SB_PATCHDIR}/${PNAME}-2.12.1-firefox-print-preview.patch.gz | patch -p1 -E --backup --verbose || exit 1

# libtool 2.2 fix
zcat ${SB_PATCHDIR}/${PNAME}-2.12.9-libtool-2.patch.gz | patch -p1 -E --backup --verbose || exit 1
