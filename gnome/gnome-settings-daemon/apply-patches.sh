
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# change font rendering
zcat ${SB_PATCHDIR}/slight-hinting.patch.gz | patch -p1 -E --backup --verbose

# https://bugzilla.gnome.org/show_bug.cgi?id=610319
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/keyboard-icon.patch

# http://dev.gentoo.org/~mrpouet/pub/patches/gnome-settings-daemon-2.28.2-gst-vol-control-support.patch.lzma
#xzcat ${SB_PATCHDIR}/gnome-settings-daemon-2.28.2-gst-vol-control-support.patch.lzma | patch -p0 -E --backup -z .gst --verbose
patch -p1 -E --backup -z .gst --verbose -i ${SB_PATCHDIR}/gnome-settings-daemon-2.30.0-gst-vol-control-support.patch

set +e +o pipefail
