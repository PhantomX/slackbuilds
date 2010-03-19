
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# https://bugzilla.gnome.org/show_bug.cgi?id=596136
zcat ${SB_PATCHDIR}/0002-Use-a-rounded-instead-of-curved-rectangle.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/0003-Improve-the-media-keys-overlay-design.patch.gz | patch -p1 -E --backup --verbose
# change font rendering
zcat ${SB_PATCHDIR}/slight-hinting.patch.gz | patch -p1 -E --backup --verbose
#
# https://bugzilla.gnome.org/show_bug.cgi?id=604918
zcat ${SB_PATCHDIR}/osd-spam.patch.gz | patch -p1 -E --backup --verbose

# related 548978
# https://bugzilla.gnome.org/show_bug.cgi?id=606794
zcat ${SB_PATCHDIR}/left-handed-single-button.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gnome-settings-daemon-2.28.1-libxklavier50.patch.gz | patch -p0 -E --backup --verbose
# http://dev.gentoo.org/~mrpouet/pub/patches/gnome-settings-daemon-2.28.2-gst-vol-control-support.patch.lzma
xzcat ${SB_PATCHDIR}/gnome-settings-daemon-2.28.2-gst-vol-control-support.patch.lzma | patch -p0 -E --backup --verbose

set +e +o pipefail
