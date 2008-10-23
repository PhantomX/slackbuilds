
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/show_bug.cgi?id=536915
zcat ${SB_PATCHDIR}/${NAME}-2.24.0-add-can-shutdown-api.patch.gz | patch -p1 -E --backup --verbose || exit 1

