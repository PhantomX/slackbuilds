  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/imap-2007-paths.patch.gz | patch -p1 -E --backup --verbose || exit 1
# See http://bugzilla.redhat.com/229781 , http://bugzilla.redhat.com/127271
zcat ${SB_PATCHDIR}/imap-2004a-doc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/imap-2007e-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/imap-2007e-shared-slk.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/imap-2007e-authmd5.patch.gz | patch -p1 -E --backup --verbose || exit 1
