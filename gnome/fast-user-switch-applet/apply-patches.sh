
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.13.0.4-update-switchdesk-location.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=402475
zcat ${SB_PATCHDIR}/${NAME}-2.20.0-username.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.17.3-defaults.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=421090
zcat ${SB_PATCHDIR}/no-session.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=477639
zcat ${SB_PATCHDIR}/throttle.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=477656
zcat ${SB_PATCHDIR}/error-dialog.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=477666
zcat ${SB_PATCHDIR}/many-users.patch.gz | patch -p1 -E --backup --verbose || exit 1
