  
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=442835
zcat ${SB_PATCHDIR}/gio-2.16-only-pass-uri-to-gio-apps.patch.gz | patch -p1 -E --backup --verbose || exit 1
