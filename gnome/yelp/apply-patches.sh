
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.9.90-modules-conf.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=319096
# zcat ${SB_PATCHDIR}/${NAME}-2.15.5-fedora-docs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.13.2-add-mime-handling.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.15.91-use-pango.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=497559
zcat ${SB_PATCHDIR}/hp.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=499744
zcat ${SB_PATCHDIR}/${NAME}-2.20.0-xulrunner.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.20.0-xulrunner2.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.21.2-libxul.patch.gz | patch -p1 -E --backup --verbose || exit 1

# RH bug #437328 / GNOME bug #511244
zcat ${SB_PATCHDIR}/${NAME}-2.22.0-beagle-search.patch.gz | patch -p1 -E --backup --verbose || exit 1
