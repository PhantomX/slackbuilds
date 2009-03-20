  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.99.2-archive-integration.patch.gz | patch -p0 -E --backup --

# http://bugzilla.gnome.org/show_bug.cgi?id=573826
zcat ${SB_PATCHDIR}/${NAME}-gdu-volume-monitor-3.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=573826
zcat ${SB_PATCHDIR}/${NAME}-1.1.7-gdu-monitor-empty-drives.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=573826
zcat ${SB_PATCHDIR}/${NAME}-1.1.7-gdu-computer-expose-devices.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=575728
zcat ${SB_PATCHDIR}/${NAME}-1.2.0-fix-daemon-mount-op-bgo575728.patch.gz | patch -p1 -E --backup --verbose || exit 1
