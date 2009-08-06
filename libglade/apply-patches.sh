  
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/show_bug.cgi?id=121025
zcat ${SB_PATCHDIR}/libglade-2.0.1-nowarning.patch.gz | patch -p1 -E --backup --verbose || exit 1
