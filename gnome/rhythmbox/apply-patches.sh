
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=428034
zcat ${SB_PATCHDIR}/rb-disable-power-plugin-by-default.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=499208
zcat ${SB_PATCHDIR}/${NAME}-0.11.3-force-python-thread-init.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=510323
zcat ${SB_PATCHDIR}/x-content.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=509701 
zcat ${SB_PATCHDIR}/soup24.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=510406
zcat ${SB_PATCHDIR}/gsd-media-player-api.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/rb-automake-warning.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=519737
zcat ${SB_PATCHDIR}/rb-activate-generic-players-from-uri.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=493996
zcat ${SB_PATCHDIR}/rb-ipod-save-artwork.patch.gz | patch -p1 -E --backup --verbose || exit 1
