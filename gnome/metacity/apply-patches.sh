  
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/default-theme.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=558723
zcat ${SB_PATCHDIR}/stop-spamming-xsession-errors.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=135056
zcat ${SB_PATCHDIR}/dnd-keynav.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=588119
zcat ${SB_PATCHDIR}/Should-set-RestartStyleHint-to-RestartIfRunning-when.patch.gz | patch -p1 -E --backup --verbose || exit 1
