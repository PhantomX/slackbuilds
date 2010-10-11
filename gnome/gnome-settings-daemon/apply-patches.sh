
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# change font rendering
zcat ${SB_PATCHDIR}/slight-hinting.patch.gz | patch -p1 -E --backup --verbose

# https://bugzilla.gnome.org/show_bug.cgi?id=610319
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/keyboard-icon.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=628538
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/display-capplet.patch

patch -p1 -E --backup -z .gst --verbose -i ${SB_PATCHDIR}/gnome-settings-daemon-2.30.0-gst-vol-control-support.patch

set +e +o pipefail
