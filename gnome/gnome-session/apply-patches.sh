
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.gnome.org/show_bug.cgi?id=598211
zcat ${SB_PATCHDIR}/xsmp-stop.patch.gz | patch -p1 -E --backup --verbose || exit 1
