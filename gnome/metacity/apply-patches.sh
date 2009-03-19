  
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/default-theme.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=558723
zcat ${SB_PATCHDIR}/stop-spamming-xsession-errors.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=557921
zcat ${SB_PATCHDIR}/metacity-canberra.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fixed upstream
zcat ${SB_PATCHDIR}/${NAME}-dont-force-bell.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fixed upstream
zcat ${SB_PATCHDIR}/${NAME}-struts.patch.gz | patch -p1 -E --backup --verbose || exit 1
