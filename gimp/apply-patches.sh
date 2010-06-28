
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# use xdg-open instead of firefox as web browser
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.2-xdg-open.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=559081
# "JPEG Save dialog preview should adjust size units"
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.7-jpeg-units.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=556896
# "Dialogs don't get minimized with single image window"
zcat ${SB_PATCHDIR}/gimp-2.6.6-minimize-dialogs.patch.gz | patch -p1 -E --backup --verbose

# backport: fix building with "gold" linker
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.8-gold.patch

# backport: GIMP crashes when clicking any scroll bar from combo boxes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.6.9-combo-popup.patch

set +e +o pipefail
