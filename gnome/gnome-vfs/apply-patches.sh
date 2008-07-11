
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.9.90-modules-conf.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.15.91-mailto-command.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-schema_about_for_upstream.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.8.2-browser_default.patch.gz | patch -p1 -E --backup --verbose || exit 1
# zcat ${CWD}/${NAME}-2.8.1-console-mount-opt.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.16.0-no-dbus.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=427958
zcat ${SB_PATCHDIR}/glob-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/show_bug.cgi?id=333041
# https://bugzilla.redhat.com/show_bug.cgi?id=335241
zcat ${SB_PATCHDIR}/${NAME}-2.20.0-ignore-certain-mountpoints.patch.gz | patch -p1 -E --backup --verbose || exit 1
