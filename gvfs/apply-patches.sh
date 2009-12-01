  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-archive-integration.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=591005
zcat ${SB_PATCHDIR}/0001-Add-AFC-backend.patch.gz | patch -p1 -E --backup --verbose || exit 1

# from upstream
zcat ${SB_PATCHDIR}/gvfs-1.4.3-smb-queryfs-old-samba.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gvfs-1.4.1-http-suport-stream-query-info.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gvfs-1.4.1-http-soup-header-parsing.patch.gz | patch -p1 -E --backup --verbose || exit 1
