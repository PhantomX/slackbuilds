
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.9.90-modules-conf.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.15.91-mailto-command.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-schema_about_for_upstream.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-browser_default.patch.gz | patch -p1 -E --backup --verbose
# https://bugzilla.redhat.com/show_bug.cgi?id=333041
# https://bugzilla.redhat.com/show_bug.cgi?id=335241
zcat ${SB_PATCHDIR}/${NAME}-2.20.0-ignore-certain-mountpoints.patch.gz | patch -p1 -E --backup --verbose
# gnome-vfs-daemon exits on dbus, and constantly restarted causing dbus/hal to hog CPU
# https://bugzilla.redhat.com/show_bug.cgi?id=486286
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.24.xx-utf8-mounts.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=435653
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-default-media-application-schema.patch

set +e +o pipefail
