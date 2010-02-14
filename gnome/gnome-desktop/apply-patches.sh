
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/concatenate-edid-descriptors.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=597874
zcat ${SB_PATCHDIR}/randr-gamma.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=599914
zcat ${SB_PATCHDIR}/ignore-xrandr-badmatch.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=147808
zcat ${SB_PATCHDIR}/per-monitor-background.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=601753
zcat ${SB_PATCHDIR}/slideshow.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=606456
zcat ${SB_PATCHDIR}/gnome-desktop-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=606457
zcat ${SB_PATCHDIR}/randr-version.patch.gz | patch -p1 -E --backup --verbose || exit 1
