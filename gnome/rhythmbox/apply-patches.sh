
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=428034
zcat ${SB_PATCHDIR}/rb-disable-power-plugin-by-default.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=374078
# https://bugzilla.redhat.com/show_bug.cgi?id=440668
zcat ${SB_PATCHDIR}/${NAME}-0.11.5-ipod-vfat.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=546962
# https://bugzilla.redhat.com/show_bug.cgi?id=458388
zcat ${SB_PATCHDIR}/${NAME}-0.11.6-libmtp-0.3.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=545555
zcat ${SB_PATCHDIR}/${NAME}-lirc-setup.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-0.11.5-xfade-buffering.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=544917
zcat ${SB_PATCHDIR}/icon-names.patch.gz | patch -p1 -E --backup --verbose || exit 1
