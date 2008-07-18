  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.2.2-archive-integration.patch.gz | patch -p0 -E --backup --
zcat ${SB_PATCHDIR}/${NAME}-0.2.4-libarchive-iso.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.2.4-smb-enable-debug.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=450453
zcat ${SB_PATCHDIR}/${NAME}-obexftp-fallback-icon.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=525779
zcat ${SB_PATCHDIR}/${NAME}-0.2.4-trash-automount.patch.gz | patch -p1 -E --backup --verbose || exit 1
