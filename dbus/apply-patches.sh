  
SB_PATCHDIR=${CWD}/patches

# from upstream
zcat ${SB_PATCHDIR}/fix-timeout-accounting.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=518541
zcat ${SB_PATCHDIR}/dbus-1.2.16-capability.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=545267
# http://bugs.freedesktop.org/25642
zcat ${SB_PATCHDIR}/fix-reload-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugs.freedesktop.org/25697
zcat ${SB_PATCHDIR}/fix-daemon-activation.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugs.freedesktop.org/24350
zcat ${SB_PATCHDIR}/keep-pending-activations.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugs.freedesktop.org/21597
zcat ${SB_PATCHDIR}/fix-reload-race.patch.gz | patch -p1 -E --backup --verbose || exit 1
