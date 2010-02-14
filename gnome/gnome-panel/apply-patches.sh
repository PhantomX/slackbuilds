
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-vendor.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.10.1-speak-to-us-ye-old-wise-fish.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-search.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-about.patch.gz | patch -p1 -E --backup --verbose || exit 1
# the next three patches belong together
# http://bugzilla.gnome.org/show_bug.cgi?id=470966
zcat ${SB_PATCHDIR}/launcher-desktop-files.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/desktop-file-monitoring.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/preferred-apps.patch.gz | patch -p1 -E --backup --verbose || exit 1
# don't pop up an error dialog if an applet from the 
# default configuration is missing; we don't want to
# add a hard dependency on e.g. tomboy 
zcat ${SB_PATCHDIR}/applet-error.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=520111
zcat ${SB_PATCHDIR}/${NAME}-2.21.92-allow-spurious-view-done-signals.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/clock-wakeups.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=579092
zcat ${SB_PATCHDIR}/clock-network.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/clock-home.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/bookmarks-submenu.patch.gz | patch -p1 -E --backup --verbose || exit 1
# from upstream
zcat ${SB_PATCHDIR}/panel-randr-crashes.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=343436
zcat ${SB_PATCHDIR}/panel-padding.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=583115
zcat ${SB_PATCHDIR}/icon-order.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=583273
zcat ${SB_PATCHDIR}/icon-padding.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=341441
zcat ${SB_PATCHDIR}/resolution-change.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/show_bug.cgi?id=537798
zcat ${SB_PATCHDIR}/fix-clock-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=604678
zcat ${SB_PATCHDIR}/polkit-error.patch.gz | patch -p1 -E --backup --verbose || exit 1
