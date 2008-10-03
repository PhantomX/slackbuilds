  
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=442835
# http://bugzilla.gnome.org/show_bug.cgi?id=528670
zcat ${SB_PATCHDIR}/gio-2.18-always-pass-fuse-file-uri.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Plug a small memory leak, will be included in 2.18.2
zcat ${SB_PATCHDIR}/${PNAME}-2.18.1-gdesktopappinfo-memleak-fix.patch.gz | patch -p2 -E --backup --verbose || exit 1
