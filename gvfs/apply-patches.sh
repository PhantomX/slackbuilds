  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.99.2-archive-integration.patch.gz | patch -p0 -E --backup --

# http://bugzilla.gnome.org/show_bug.cgi?id=573826
zcat ${SB_PATCHDIR}/${NAME}-1.1.7-gdu-computer-expose-devices.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=578681
zcat ${SB_PATCHDIR}/${NAME}-bash-completion.patch.gz | patch -p1 -E --backup --verbose || exit 1
# From svn:
zcat ${SB_PATCHDIR}/${NAME}-1.2.2-ssh-auth-sock.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Gdu volume monitor patches, from http://cgit.freedesktop.org/~david/gvfs/log/?h=gdu-volume-monitor
#
# http://bugzilla.gnome.org/show_bug.cgi?id=573826
zcat ${SB_PATCHDIR}/gdu-0001-Bug-573826-gdu-volume-monitor.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=573826
zcat ${SB_PATCHDIR}/gdu-0002-Fix-how-we-determine-if-a-volume-is-ignored.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/show_bug.cgi?id=494144
zcat ${SB_PATCHDIR}/gdu-0003-Avoid-automounting-volumes-on-virtual-and-unknown-bu.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gdu-0004-Remove-debug-spew.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=495033
zcat ${SB_PATCHDIR}/gdu-0005-Don-t-add-a-volume-if-the-device-is-mounted-and-igno.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gdu-0006-Ignore-drives-if-all-volumes-of-the-drive-are-ignore.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=495152
zcat ${SB_PATCHDIR}/gdu-0008-ignore-drives-without-volumes.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gdu-0009-never-ignore-drives-without-media.patch.gz | patch -p1 -E --backup --verbose || exit 1
