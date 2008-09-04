  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/gkeyfile-bool-nocase.patch.gz | patch -p0 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=442835
zcat ${SB_PATCHDIR}/gio-2.16-only-pass-uri-to-gio-apps.patch.gz | patch -p1 -E --backup --verbose || exit 1
