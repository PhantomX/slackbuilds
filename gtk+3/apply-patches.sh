
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream dropped toolbar/icons size settings...
# So revert some, until I figure out a better way to emulate the old behavior.
patch -p1 -R --backup --verbose -i ${SB_PATCHDIR}/gtk+3-3.10.0-gtk-recent-files-limit.patch
patch -p1 -R --backup --verbose -i ${SB_PATCHDIR}/gtk+3-3.10.0-gtk-toolbar-icon-size.patch
patch -p1 -R --backup --verbose -i ${SB_PATCHDIR}/gtk+3-3.10.0-gtk-toolbar-style.patch
# Disable this @#$& by default
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/gtk+3-3.16.4-disable-overlay.patch

### Debian
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/015_default-fallback-icon-theme.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/016_no_offscreen_widgets_grabbing.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/017_no_offscreen_device_grabbing.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/060_ignore-random-icons.patch

set +e +o pipefail
