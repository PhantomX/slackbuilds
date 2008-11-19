  
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=442835
zcat ${SB_PATCHDIR}/gio-2.18-always-pass-fuse-file-uri.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=528320 (from svn)
zcat ${SB_PATCHDIR}/glib-2.18.2-no-generic-icons.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/glib-i386-atomic.patch.gz | patch -p1 -E --backup --verbose || exit 1
