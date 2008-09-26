
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/show_bug.cgi?id=319096
# zcat ${SB_PATCHDIR}/${NAME}-2.15.5-fedora-docs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.13.2-add-mime-handling.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.15.91-use-pango.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=497559
zcat ${SB_PATCHDIR}/hp.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libxul.patch.gz | patch -p1 -E --backup --verbose || exit 1
