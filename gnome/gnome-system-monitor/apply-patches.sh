  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.patch.gz | patch -p0 -E --backup --verbose || exit 1

# send upstream: http://bugzilla.gnome.org/show_bug.cgi?id=491462
zcat ${SB_PATCHDIR}/${NAME}-2.25.91-polkit.patch.gz | patch -p1 -E --backup --verbose || exit 1

# sent upstream: http://bugzilla.gnome.org/show_bug.cgi?id=421912
zcat ${SB_PATCHDIR}/session.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=495730
zcat ${SB_PATCHDIR}/polkit1.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=592747
zcat ${SB_PATCHDIR}/buttons.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=592758
zcat ${SB_PATCHDIR}/memmapsdialog.patch.gz | patch -p1 -E --backup --verbose || exit 1
