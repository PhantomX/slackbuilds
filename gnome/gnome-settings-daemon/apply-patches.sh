
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.gnome.org/show_bug.cgi?id=596136
zcat ${SB_PATCHDIR}/osd-rounded-rectangle.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/osd-visual-refresh.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gnome-settings-daemon-2.28.1-libxklavier50.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://dev.gentoo.org/~mrpouet/pub/patches/gnome-settings-daemon-2.28.0-gst-vol-control-support.patch.lzma
xzcat ${SB_PATCHDIR}/gnome-settings-daemon-2.28.0-gst-vol-control-support.patch.lzma | patch -p1 -E --backup --verbose || exit 1
