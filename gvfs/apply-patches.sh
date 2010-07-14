
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-archive-integration.patch.gz | patch -p1 -E --backup --verbose

# Recognize gphoto2 cameras which don't implement get storageinfo
# https://bugzilla.redhat.com/show_bug.cgi?id=552856
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gvfs-1.5.1-gphoto2-no-storageinfo-support.patch

# If you delete an empty folder with an emblem, and then try to open your trash nautilus hangs
# https://bugzilla.gnome.org/show_bug.cgi?id=614544
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gvfs-1.6.2-stringv-dbus.patch

set +e +o pipefail
