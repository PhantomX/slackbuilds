  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-0.3.0-get-vt-from-display-instead-of-controlling-tty.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-0.3.0-allowsetidle.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugs.freedesktop.org/show_bug.cgi?id=19020
# http://bugs.freedesktop.org/show_bug.cgi?id=20471
zcat ${SB_PATCHDIR}/${NAME}-dbus-permissions.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${PNAME}-skipvalidation.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fix directory leaks, bug #258685
zcat ${SB_PATCHDIR}/${NAME}-0.2.10-directory-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Clean up at_console compat files, bug #257761
zcat ${SB_PATCHDIR}/${NAME}-0.2.10-cleanup_console_tags.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix inability to shutdown/restart
zcat ${SB_PATCHDIR}/${NAME}-0.3.0-shutdown.patch.gz | patch -p1 -E --backup --verbose || exit 1

