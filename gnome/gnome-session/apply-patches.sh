
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.2.2-icons.patch.gz | patch -p1 -E --backup --verbose || exit 1

# too much crashing
zcat ${SB_PATCHDIR}/${NAME}-2.13.4-no-crashes.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=350848
# The gconf bits weren't accepted upstream, so we'll
# need to figure something out here
zcat ${SB_PATCHDIR}/${NAME}-2.17.5-window-manager.patch.gz | patch -p1 -E --backup --verbose || exit 1

# don't pop up the dialog as it can take longer than 5 seconds
zcat ${SB_PATCHDIR}/${NAME}-2.19.4-atspi-timeout.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=475468
#zcat ${SB_PATCHDIR}/ice-leaks.patch.gz | patch -p1 -E --backup --verbose || exit 1
