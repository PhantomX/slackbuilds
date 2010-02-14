  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.6.0-newer-slackware.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-default-permissions.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Apply fix from ubuntu for CVE 2008 4311
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-cve-2008-4311.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Apply fix from ubuntu for CVE 2008 6792, bug #270326
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-1ubuntu1.1.patch.gz | patch -p1 -E --backup --verbose || exit 1
