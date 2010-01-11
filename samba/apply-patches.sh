  
SB_PATCHDIR=${CWD}/patches

# generic patches
zcat ${SB_PATCHDIR}/samba-3.2.0pre1-pipedir.patch.gz | patch -p1 -E --backup --verbose || exit 1
# The passwd part has been applied, but not the group part
#zcat ${SB_PATCHDIR}/samba-3.2.0pre1-grouppwd.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/samba-3.2.5-inotify.patch.gz | patch -p0 -E --backup --verbose || exit 1
