
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/gimp-2.6.0-xdg-open.patch.gz | patch -p1 -E --backup --verbose
# http://bugzilla.gnome.org/show_bug.cgi?id=559081
# "JPEG Save dialog preview should adjust size units"
zcat ${SB_PATCHDIR}/gimp-2.6.2-jpeg-units.patch.gz | patch -p1 -E --backup --verbose
# http://bugzilla.gnome.org/show_bug.cgi?id=556896
# "Dialogs don't get minimized with single image window"
zcat ${SB_PATCHDIR}/gimp-2.6.6-minimize-dialogs.patch.gz | patch -p1 -E --backup --verbose

# backport: fix building with "gold" linker
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.8-gold.patch
# backport: statusbar code needed for GTK+ >= 2.19.1 (#559726)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.8-gtk219.patch

zcat ${SB_PATCHDIR}/gimp-2.6.8-libpng14.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
