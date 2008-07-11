
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.19.5-vendor.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.10.1-speak-to-us-ye-old-wise-fish.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-2.17.91-about-fedora.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.13.5-switch-user.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.16.1-search.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.21.92-about-this-computer.patch.gz | patch -p1 -E --backup --verbose || exit 1
# the next three patches belong together
# http://bugzilla.gnome.org/show_bug.cgi?id=470966
zcat ${SB_PATCHDIR}/launcher-desktop-files.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/desktop-file-monitoring.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/preferred-apps.patch.gz | patch -p1 -E --backup --verbose || exit 1
# don't pop up an error dialog if an applet from the 
# default configuration is missing; we don't want to
# add a hard dependency on e.g. tomboy 
zcat ${SB_PATCHDIR}/applet-error.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=511881
zcat ${SB_PATCHDIR}/${NAME}-2.22.0-ck-shutdown.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=520111
zcat ${SB_PATCHDIR}/${NAME}-2.21.92-allow-spurious-view-done-signals.patch.gz | patch -p1 -E --backup --verbose || exit 1

# fixed upstream
zcat ${SB_PATCHDIR}/${NAME}-larger-find-window.patch.gz | patch -p1 -E --backup --verbose || exit 1

# some upstream fixes 
zcat ${SB_PATCHDIR}/clock1.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/clock2.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/clock-help.patch.gz | patch -p1 -E --backup --verbose || exit 1
