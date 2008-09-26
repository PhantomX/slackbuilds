
SB_PATCHDIR=${CWD}/patches

# Some changes to default config
zcat ${SB_PATCHDIR}/${NAME}-2.5.7-rhconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/background-no-delay.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Why is this not upstream ?
zcat ${SB_PATCHDIR}/${NAME}-2.23.5-dynamic-search.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rtl-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-gvfs-desktop-key.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=171655
zcat ${SB_PATCHDIR}/${NAME}-2.22.0-treeview-xds-dnd.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=519743
zcat ${SB_PATCHDIR}/${NAME}-filetype-symlink-fix.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=553073
zcat ${SB_PATCHDIR}/filesystem-id-cmp.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=553084
zcat ${SB_PATCHDIR}/description-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1
