
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/show_bug.cgi?id=552780
zcat ${SB_PATCHDIR}/xml-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=552815
zcat ${SB_PATCHDIR}/startup_id-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1
