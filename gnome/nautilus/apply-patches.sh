
SB_PATCHDIR=${CWD}/patches

# Some changes to default config
zcat ${SB_PATCHDIR}/${NAME}-2.5.7-rhconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/background-no-delay.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Why is this not upstream ?
zcat ${SB_PATCHDIR}/${NAME}-2.22.1-dynamic-search.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rtl-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-gvfs-desktop-key.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=528675
zcat ${SB_PATCHDIR}/${NAME}-fix-open-folder.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=530720
zcat ${SB_PATCHDIR}/${NAME}-copymove_inside_itself.patch.gz | patch -p0 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=444639
zcat ${SB_PATCHDIR}/${NAME}-2.22-default-to-asking.patch.gz | patch -p1 -E --backup --verbose || exit 1
