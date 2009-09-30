  
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/show_bug.cgi?id=592661
zcat ${SB_PATCHDIR}/dupe-id.patch.gz | patch -p1 -E --backup --verbose || exit 1
