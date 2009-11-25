
SB_PATCHDIR=${CWD}/patches

# https://bugs.freedesktop.org/show_bug.cgi?id=23297
zcat ${SB_PATCHDIR}/dbus-glib-support_duplicate_object_registrations.patch.gz | patch -p1 -E --backup --verbose || exit 1
