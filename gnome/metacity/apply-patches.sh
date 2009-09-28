  
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/default-theme.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=558723
zcat ${SB_PATCHDIR}/stop-spamming-xsession-errors.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=135056
zcat ${SB_PATCHDIR}/dnd-keynav.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=588119
zcat ${SB_PATCHDIR}/Should-set-RestartStyleHint-to-RestartIfRunning-when.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=593355
zcat ${SB_PATCHDIR}/0001-bell-increase-bell-rate-limit-from-1-s-to-1-100ms.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=593356
zcat ${SB_PATCHDIR}/0001-sound-ask-libcanberra-to-cache-alert-desktop-switch-.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=593358
zcat ${SB_PATCHDIR}/0001-tooltip-set-window-type-hint-for-self-drawn-tooltips.patch.gz | patch -p1 -E --backup --verbose || exit 1
