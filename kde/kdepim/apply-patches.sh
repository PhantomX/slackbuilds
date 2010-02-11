  
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.redhat.com/show_bug.cgi?id=496988
zcat ${SB_PATCHDIR}/${NAME}-4.3.1-kmail-saveAttachments.patch.gz | patch -p0 -E --backup --verbose || exit 1

# upstream patches
zcat ${SB_PATCHDIR}/${NAME}-4.4.1-kontact-startup.patch.gz | patch -p1 -E --backup --verbose || exit 1
