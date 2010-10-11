
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-vendor.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.10.1-speak-to-us-ye-old-wise-fish.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-search.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-about.patch.gz | patch -p1 -E --backup --verbose
# the next three patches belong together
# http://bugzilla.gnome.org/show_bug.cgi?id=470966
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/launcher-desktop-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/desktop-file-monitoring.patch
zcat ${SB_PATCHDIR}/preferred-apps.patch.gz | patch -p1 -E --backup --verbose
# don't pop up an error dialog if an applet from the 
# default configuration is missing; we don't want to
# add a hard dependency on e.g. tomboy 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/applet-error.patch

# http://bugzilla.gnome.org/show_bug.cgi?id=520111
zcat ${SB_PATCHDIR}/${NAME}-2.21.92-allow-spurious-view-done-signals.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=579092
zcat ${SB_PATCHDIR}/clock-network.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bookmarks-submenu.patch
# from upstream
# http://bugzilla.gnome.org/show_bug.cgi?id=343436
zcat ${SB_PATCHDIR}/panel-padding.patch.gz | patch -p1 -E --backup --verbose
# https://bugzilla.gnome.org/show_bug.cgi?id=583273
patch -p1 -E --backup -z .icon-padding --verbose -i ${SB_PATCHDIR}/icon-padding.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=537798
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-clock-crash.patch
patch -p1 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/gnome-panel-libs.patch

set +e +o pipefail
