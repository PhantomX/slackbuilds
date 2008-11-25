  
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=442835
zcat ${SB_PATCHDIR}/gio-2.18-always-pass-fuse-file-uri.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/glib-i386-atomic.patch.gz | patch -p1 -E --backup --verbose || exit 1
