  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-archive-integration.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=591005
zcat ${SB_PATCHDIR}/0001-Add-AFC-backend.patch.gz | patch -p1 -E --backup --verbose || exit 1
